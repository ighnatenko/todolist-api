class Comment < ApplicationRecord
  belongs_to :task
  validates :content, presence: true
  mount_uploader :file, ImageUploader
  validates :file, file_size: { less_than: 10.megabytes }
end