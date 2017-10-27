class User < ApplicationRecord

  attr_reader :password

  validate :username, uniqueness: true
  validate :username, :session_token, :password_digest, presence: true
  validate :password, length: { minimun: 6, allow_nil: true }

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.is_password(password)
      user
    else
      nil
    end
  end

  def self.reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    if self.session_token.nil?
      self.session_token = User.generate_session_token
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    bcrypt_digest = BCrypt::Password.new(self.password_digest)
    bcrypt_digest.is_password?(password)
  end


end
