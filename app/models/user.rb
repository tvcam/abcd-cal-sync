class User < ApplicationRecord
end


# u = User.first

# url = URI("https://www.googleapis.com/calendar/v3/users/me/calendarList")

# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true
# request = Net::HTTP::Get.new(url)
# request["authorization"] = "Bearer #{u.access_token}"

# response = http.request(request)
