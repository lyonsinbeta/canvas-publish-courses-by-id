require 'rest-client'

# The URL to the Canvas instance
CANVAS = ""

# API Token with sufficient privileges.
TOKEN  = ""

# Array of (up to 500) Canvas course IDs to publish
# This script expects the Canvas ID, not the SIS ID, though it could be modified to use SIS ID
courses = []
url_params = ""

courses.each do |course_id|
  if courses.first == course_id
    url_params += "#{course_id}"
  elsif courses.last == course_id
    url_params += "course_ids[]=#{course_id}"
  else
    url_params += "course_ids[]=#{course_id}&"
  end
end

courses.each do |course_id|
  response = RestClient.put "#{CANVAS}/api/v1/accounts/self/courses",
            { "course_ids[]" => url_params,
              "event" => "offer" },
              :Authorization => "Bearer #{TOKEN}"
end

