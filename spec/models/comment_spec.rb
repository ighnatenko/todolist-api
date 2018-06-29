require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'check relations' do
    is_expected.to belong_to(:task)
  end

  it 'check validation' do
    is_expected.to validate_presence_of(:content)
  end
end