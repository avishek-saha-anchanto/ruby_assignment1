class Card < ApplicationRecord
  validates :title, presence: true
end