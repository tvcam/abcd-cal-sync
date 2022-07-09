class User < ApplicationRecord
  has_many :calendars, dependent: :delete_all
  has_many :events, through: :calendars
end

# u = User.first

# url = URI("https://www.googleapis.com/calendar/v3/users/me/calendarList")

# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true
# request = Net::HTTP::Get.new(url)
# request["authorization"] = "Bearer #{u.access_token}"

# response = http.request(request)
