module Api
  class TaskSerializer < ActiveModel::Serializer
    attributes :id, :title, :done, :index, :expiration_date
    has_many :comments

    def expiration_date
      object.created_at.strftime('%d/%m/%y')
    end
  end
end