# frozen_string_literal: true

module Api
  class TaskSerializer < ActiveModel::Serializer
    attributes :id, :title, :done, :index, :expiration_date
    has_many :comments
  end
end
