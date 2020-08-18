class JustEncrypt
  require 'base64'
  require 'openssl'
  
  def self.decrypt(base64_encrypted_text)
    # cipher for encrypting/decrypting
    secret = Rails.application.credentials.just_encrypt[:secret]
    key = Digest::SHA1.hexdigest(secret).slice(0..31)
    encrypted_text = Base64.decode64(base64_encrypted_text)
    # set cipher for decryption
    cipher = OpenSSL::Cipher.new("aes-256-cbc")
    cipher.decrypt
    cipher.key = key
    cipher.iv = encrypted_text[0..15]
  
    # decryption
    decrypted = cipher.update(encrypted_text[16..encrypted_text.length-1])
    decrypted << cipher.final
    decrypted
  end

  def self.encrypt(text)
    # cipher for encrypting/decrypting
    secret = Rails.application.credentials.just_encrypt[:secret]
    key = Digest::SHA1.hexdigest(secret).slice(0..31)
    # set cipher for encryption
    cipher = OpenSSL::Cipher::AES256.new(:CBC)
    cipher.encrypt
    cipher.key = key
    iv = cipher.random_iv
    cipher.iv = iv
    
    # encrypt the message
    encrypted = cipher.update(text)
    encrypted << cipher.final
    Base64.encode64(iv + encrypted)
  end
end

