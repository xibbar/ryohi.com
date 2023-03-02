require 'test_helper'

class MailerTest < ActionMailer::TestCase
  setup do
    @user = create(:user)
  end

  test 'confirmation_email' do
    email = Mailer.confirmation_email(@user)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["development@ryohi.sakura.ne.jp"], email.from
    assert_equal [@user.email], email.to
    assert_equal "#{Setting.subject}#{I18n.t('mail.user.activation.needed')}", email.subject
    #erb = ERB.new(File.read("#{Rails.root}/app/views/mailer/confirmation_email.text.erb"))
    #assert_equal erb.result(binding).gsub(/\s/, ''), email.body.to_s.gsub(/\s/, '')
  end

  test 'activated' do
    email = Mailer.activated(@user)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["development@ryohi.sakura.ne.jp"], email.from
    assert_equal [@user.email], email.to
    assert_equal "#{Setting.subject}#{I18n.t('mail.user.activation.complete')}", email.subject
  end

  test 'forgot_password' do
    @user.passwords.create
    email = Mailer.forgot_password(@user)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["development@ryohi.sakura.ne.jp"], email.from
    assert_equal [@user.email], email.to
    assert_equal "#{Setting.subject}#{I18n.t('mail.user.forgot_password')}", email.subject
  end
end
