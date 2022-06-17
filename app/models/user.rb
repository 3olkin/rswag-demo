class User < ApplicationRecord
  has_secure_password

  has_many :messages

  def as_json(options = nil)
    super(options).except('password_digest')
  end
end
