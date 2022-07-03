class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validate :password_complexity

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/
    errors.add :password, "Сложность пароля не соблюдена. Длина должна быть 8-70 символов включая: 1 заглавную букву, 1 печатную букву, 1 цифру и 1 спец. символ"
  end
end
