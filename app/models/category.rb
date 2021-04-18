class Category < ApplicationRecord
  has_many :question_categories, dependent: :destroy
  has_many :questions, through: :post_categories
end
