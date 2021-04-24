class Question < ApplicationRecord
  mount_uploaders :pictures, PictureUploader
  mount_uploader :video, VideoUploader
  belongs_to :user
  has_many :question_categories, dependent: :destroy
  has_many :categories, through: :question_categories
  has_many :answers, dependent: :destroy

  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true, length: { maximum: 10_000 }

  enum status: { unsolved: 0, solved: 1 }

  def split_id_from_youtube_url
    # YoutubeならIDのみ抽出
    youtube.split('/').last if youtube?
  end

  def adjust_status
    if best_answer_id.present?
        self.solved!
         end
  end

end
