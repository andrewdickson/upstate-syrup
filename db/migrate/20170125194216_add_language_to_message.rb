class AddLanguageToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :spam, :boolean, default: false
    add_column :messages, :language, :string, default: "english"
    add_column :messages, :has_link, :boolean, default: false
    add_column :messages, :captcha, :text
    add_column :messages, :captcha_response, :text
    add_column :messages, :captcha_password, :string
    add_column :messages, :url, :string
    add_column :messages, :filled_hidden_url, :boolean, default: false
  end
end
