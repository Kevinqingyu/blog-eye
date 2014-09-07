class Point < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  validates :name, presence: true, allow_blank: false
  validates :code, presence: true, allow_blank: false, uniqueness: { case_sensitive: false }

end
