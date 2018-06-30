require 'rails_helper'

RSpec.describe User, type: :model do
    %i[email encrypted_password].each do |field|
      it "validate presense of #{field}" do
        is_expected.to validate_presence_of(field)
      end
    end
 
    it 'has many projects' do
      is_expected.to have_many(:projects)
    end
end