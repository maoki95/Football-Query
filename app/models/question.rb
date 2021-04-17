class Question < ApplicationRecord
  mount_uploaders :pictures, PictureUploader
  mount_uploader :video, VideoUploader
  belongs_to :user

  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true, length: { maximum: 10_000 }

  enum status: { unsolved: 0, solved: 1 }
end
