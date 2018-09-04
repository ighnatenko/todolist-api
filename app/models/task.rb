# frozen_string_literal: true

# Task
class Task < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :project
  validates :title, :index, presence: true
end
