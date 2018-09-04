# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'check relations' do
    is_expected.to have_many(:tasks).dependent(:destroy)
  end

  it 'check validation' do
    is_expected.to validate_presence_of(:title)
  end
end
