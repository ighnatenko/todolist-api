module Api
  class CommentSerializer < ActiveModel::Serializer
    attributes :id, :content, :created_date, :task_id, :file

    def created_date
      object.created_at.strftime('%d/%m/%y')
    end
  end
end