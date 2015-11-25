# アカウントをCompanyからUserに切り替えるのに情報をコピーする
class CopyAuthoritiesToUsers < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do
      add_column :companies, :user_id, :integer

      Email.with_deleted.delete_all
      rename_column :emails,    :company_id, :user_id
      Password.with_deleted.delete_all
      rename_column :passwords, :company_id, :user_id

      Company.all.each do |company|
        user = User.new

        target_columns.each do |column|
          if column == 'activation_token'
            user.activation_token = 'sample'
          else
            user[ column ] = company.send( column )
          end
        end

        user.save!
        user.companies << company
      end
    end
    p "戻す際はユーザ情報を手で消すこと。"
    p "メールアドレス、パスワードの変更途中の情報は削除されています。"
  end

  def down
    ActiveRecord::Base.transaction do
      User.all.each do |user|
        user.companies.each.with_index(1) do |company, i|

          target_columns.each do |column|
            if column == 'email'
              email = user.email.split(/@/)
              company.email = "#{ email[0] }+#{ i }@#{ email[1] }"
            else
              company[ column ] = user.send( column )
            end
          end

          company.save!
        end
      end

      remove_column :companies, :user_id

      Email.with_deleted.delete_all
      rename_column :emails,    :user_id, :company_id
      Password.with_deleted.delete_all
      rename_column :passwords, :user_id, :company_id

      # User.destroy_all
    end

    p "スクリプトでユーザ情報を消すと企業情報も消えてしまうので、手で消すこと。"
    p "メールアドレス、パスワードの変更途中の情報は削除されています。"
  end

  private

  def target_columns
    %w(
      login
      email
      crypted_password
      salt
      name
      state
      activation_token
      activation_token_expires_at
      reset_password_token
      reset_password_token_expires_at
      reset_password_email_sent_at
      login_key
    )
  end
end
