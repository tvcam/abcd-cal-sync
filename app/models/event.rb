class Event < ApplicationRecord
  belongs_to :calendar

  serialize :attendees, Array
  serialize :creator, Hash
  serialize :event_end, Hash
  serialize :event_start, Hash

  scope :start_at_today, -> { where(start_at: Date.current.all_day) }
  scope :end_at_today, -> { where(end_at: Date.current.all_day) }
  scope :today, -> { Event.start_at_today.or(Event.end_at_today) }
end
