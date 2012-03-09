require 'openssl'
require 'digest/sha2'
require 'base64'

module AppyantraAdmin
  module Crypto

    # Symmetric-key encryption
    mattr_accessor :key_phrase
    @@key_phrase = 'Some random phrase'

    SHA256 = Digest::SHA2.new(256)
    AES = OpenSSL::Cipher::Cipher.new("AES-256-CBC")
    IV = "I" * 32
    KEY = SHA256.digest(self.key_phrase)

    # Encrypts the payload
    def self.encrypt(payload)
      AES.encrypt
      AES.key = KEY
      AES.iv = IV
      AES.update(payload) + AES.final
    end

    # Decrypts the encrypted data
    def self.decrypt(encrypted_data)
      AES.decrypt
      AES.key = KEY
      AES.iv = IV
      AES.update(encrypted_data) + AES.final
    end

    def self.encrypt_to_base64(data)
      return unless data
      Base64.encode64(encrypt(data))
    end

    def self.decrypt_from_base64(data)
      return unless data
      decrypt(Base64.decode64(data))
    end
  end
end