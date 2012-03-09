require 'appyantra_admin/crypto'

class EncryptedText < ActiveRecord::Base

  before_save :encrypt_value

  def entity_value
    AppyantraAdmin::Crypto.decrypt_from_base64(self.value)
  end

  def entity_value=(value)
    self.value = value
    self.save
  end

  def encrypt_value
    self.value = AppyantraAdmin::Crypto.encrypt_to_base64(self.value)
  end

end