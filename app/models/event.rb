class Event < ApplicationRecord
  belongs_to :calendar

  serialize :attendees, Array
  serialize :creator, Hash
  serialize :event_end, Hash
  serialize :event_start, Array
end
