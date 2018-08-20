# frozen_string_literal: true

# Project
class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
end
