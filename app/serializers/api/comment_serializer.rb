module Api
  class CommetSerializer < ActiveModel::Serializer
    attributes :id, :content, :created_date

    def created_date
      object.created_at.strftime('%d/%m/%y')
    end
  end
end