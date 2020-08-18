class JustEncrypt
  require 'base64'
  require 'openssl'

  def self.decrypt(data, cipher_key = nil)
    cipher = OpenSSL::Cipher.new 'aes-256-cbc'
    cipher.decrypt
    cipher.key = Rails.application.credentials.lets_encrypt[:secret]
    # Decryption Process
    unescaped = CGI.unescape(data) # Remove urlencode
    decoded = Base64.decode64(unescaped) # Decode from base64
    cipher.iv = decoded[0..15] # This corresponds to the first 16 characters of the received data
    decrypted = cipher.update(decoded[16..decoded.length - 1]) # First step for decrypt
    decrypted << cipher.final # Decryption finished
    timestamp = decrypted[-10..(decrypted.length - 1)].to_i
    # Return decrypted data
    decrypted[0..(decrypted.length - 11)]
  end

  def self.encrypt(raw_user_cod, cipher_key = nil)
    timestamp = Time.now.utc.to_i
    secret = Rails.application.credentials.lets_encrypt[:secret]
    cipher = OpenSSL::Cipher.new('aes-256-cbc')

    iv = cipher.random_iv
    cipher.encrypt
    cipher.key = secret

    encrypted_data = cipher.update(raw_user_cod + timestamp.to_s)
    encrypted_data << cipher.final
    data = CGI.escape(Base64.strict_encode64(iv.to_s + encrypted_data))

    data
  end
end

