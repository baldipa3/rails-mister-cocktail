class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_one_attached :photo
  has_one :user

  validates :name, uniqueness: true, presence: true
end
