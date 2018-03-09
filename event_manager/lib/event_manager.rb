require 'csv'
require 'google/apis/civicinfo_v2'  
require 'erb'


def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phone(phone)
  phone = phone.gsub(/(-|\.|,|\s+|\(|\))/, "")
  phone = "INVALID" if ((phone.length < 10) || (phone.length > 11))
    
  if phone.length == 11
    if phone[0] == "1"
      phone = phone[1..-1]
    else
      phone = "INVALID"
    end
  end
    phone
end

def text_alerts(name, phone)
  if !File.file?("./text_alerts.csv")
    File.open("./text_alerts.csv", "a") { |f| f.puts "name, phone" }
  end
  File.open("./text_alerts.csv", "a") { |f| f.puts "#{name}, #{phone}" }  
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
                                  address: zip, 
                                  levels: 'country', 
                                  roles: ['legislatorUpperBody', 'legislatorLowerBody']).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def create_customized_templates(id, name, legislators)
  lines = File.read("form_letter.erb")
  template = ERB.new(lines)

  Dir.mkdir("output") unless Dir.exists? "output"

  File.open("./output/#{id}.html", "w") {|file| file.puts template.result(binding)}
end


puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
text_alerts = []
registration_hours = Hash.new(0)
registration_days = Hash.new(0)

contents.each do |row|

  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone(row[:homephone])
  text_alerts(name, phone)
  legislators = legislators_by_zipcode(zipcode)
  results = create_customized_templates(id, name, legislators)

  registration_hours[DateTime.strptime(row[:regdate], "%m/%d/%y %H:%M").hour] += 1
  #registration_days[Date.strptime(row[:regdate], "%m/%d/%y %H:%M").wday] += 1
  registration_days[Date::DAYNAMES[Date.strptime(row[:regdate], "%m/%d/%y %H:%M").wday]] += 1

end

puts "REGISTRATION HOURS: #{registration_hours}"
puts "REGISTRATION DAYS: #{registration_days}"


