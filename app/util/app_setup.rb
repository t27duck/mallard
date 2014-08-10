class AppSetup

  def self.set_password(password)
    crypted_password = BCrypt::Password.create(password)
    auth_token = SecureRandom.urlsafe_base64
    ConfigInfo.set(:password, crypted_password)
    ConfigInfo.set(:auth_token, auth_token)
    auth_token
  end
end
