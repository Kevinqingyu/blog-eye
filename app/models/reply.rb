
require 'word_check'
include WordCheck

class Reply < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to :post

  has_one :blogger, through: :post, source: 'user'
  has_many :messages, as: :target, dependent: :destroy

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, allow_blank: false

  default_scope { order('created_at desc') }

  before_save :validate_sensitive
  after_create :message_to_at_users

  def published_time
    self.created_at.strftime('%Y-%m-%d %H:%M')
  end

  def message_to_at_user(at_user)
    message = self.messages.build(
      is_read: false,
      user_id: at_user.id,
      from_user_id: self.user.id,
      body: "#{self.user.uid} 在评论中提到了你，快去查看吧！"
    )
    message.save
  end

  def message_to_blogger
    return if self.blogger.id != self.user.id
    message = self.messages.build(
      is_read: false,
      user_id: self.blogger.id,
      from_user_id: self.user.id,
      body: self.content
    )
    message.save
  end

  private
  def message_to_at_users
    at_users = []
    self.content.gsub(/(@\w+ )/){
      uid = "#{$1.strip.sub('@', '')}"
      user = User.find_by(uid: uid)
      at_users << user if user.present?
    }

    at_users.each { |at_user| self.message_to_at_user(at_user) }
    self.message_to_blogger unless at_users.include?(self.blogger)
  end

  def validate_sensitive
    word = WordCheck.first_sensitive(self.inspect)
    if word.present?
      errors.add(:base, "回复内容包含敏感词汇: #{word}")
      return false
    end
  end
end
