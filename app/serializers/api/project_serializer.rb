# frozen_string_literal: true

module Api
  class ProjectSerializer < ActiveModel::Serializer
    attributes :id, :title
    has_many :tasks
  end
end
