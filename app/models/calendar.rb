class Calendar < ApplicationRecord
  belongs_to :user
  has_many :events, -> { where.not(start_at: nil).order(:start_at).limit(20) }, dependent: :delete_all
  has_many :today_events, -> { today.where.not(start_at: nil).order(:start_at).limit(20) }, class_name: 'Event', dependent: :delete_all
end
