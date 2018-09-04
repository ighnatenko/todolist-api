# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'check relations' do
    is_expected.to have_many(:comments).dependent(:destroy)
  end

  it 'check validation' do
    is_expected.to validate_presence_of(:title)
    is_expected.to validate_presence_of(:index)
  end
end
