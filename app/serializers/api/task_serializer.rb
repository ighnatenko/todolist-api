module Api
  class TaskSerializer < ActiveModel::Serializer
    attributes :id, :title, :done, :index
    has_many :comments
  end
end