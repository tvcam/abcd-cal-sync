class Calendar < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :delete_all
end
