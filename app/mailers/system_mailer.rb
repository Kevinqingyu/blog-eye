
# Sends admin mail for system events
class SystemMailer < ActionMailer::Base
  default from: Settings.site_mailer.from, return_path: Settings.site_mailer.return_path

  def send_welcome_mail(send_to)
    @send_to = send_to

    mail(to: @send_to, subject: "博客眼欢迎你") do |format|
      format.html { render "mailers/system_mailer/welcome_register", layout: false }
    end
  end

  # Send welcome instructions to new user
  # @param user the user to send the mail to
  def send_sensitive_mail(send_to, content)
    @send_to = send_to
    @content = content

    mail(to: @send_to, subject: "博客眼敏感词检测结果") do |format|
      format.html { render "mailers/system_mailer/page_sensitive", layout: false }
    end
  end
end
