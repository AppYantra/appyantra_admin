require 'spec_helper'

describe EncryptedText do

  let(:name) { "secret" }
  let(:secret_text) { "This is some top secret text" }

  it "can be saved and retrieved" do
    encr_text = EncryptedText.create(name: name, value: secret_text)
    encr_text.entity_value.should == secret_text
  end

end
