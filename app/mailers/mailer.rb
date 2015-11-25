class Mailer < ActionMailer::Base
  default from: Setting.default_from

  def confirmation_email(user)
    @user = user
    create_mail(user.email, I18n.t('mail.user.activation.needed'))
  end

  def activated(user)
    @user = user
    create_mail(user.email, I18n.t('mail.user.activation.complete'))
  end

  def email(user)
    @user = user
    create_mail(user.email, I18n.t('mail.user.activation.email'))
  end

  def forgot_password(user)
    @user = user
    create_mail(user.email, I18n.t('mail.user.forgot_password'))
  end


  private

  def create_mail(to, subject, from=Setting.default_from)
    mail = mail(to: to, from: from, subject: "#{Setting.subject}#{subject}")
    mail.transport_encoding = "8bit"
    mail
  end
end
