# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :questions
  has_many :answers

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :introduce, length: { maximum: 150 }

  def own?(object)
    id == object.user_id
  end
end
