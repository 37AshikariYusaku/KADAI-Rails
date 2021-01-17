class User < ApplicationRecord
	# validates :name, presence: true
	
	# 名前の長さに制限を追加する
	validates :name, presence: true, length: {maximum: 15}
	
	# メールアドレスの正規表現を追加してください
	VALID_MAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_MAIL_REGEX}
	
	# パスワードの文字数制限を追加する
	# validates :password, presence: true, length: {in: 8..32}
	
	# パスワードをアルファベット、数字の混合のみ可能にしてください
	VALID_PASSWORD_REGEX = /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]\w{8,32}\z/
  validates :password, presence: true,
            format: { with: VALID_PASSWORD_REGEX}
	
	
	has_secure_password
end
