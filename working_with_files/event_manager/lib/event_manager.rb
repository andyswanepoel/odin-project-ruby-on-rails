# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = '' # Add your API key
  civic_info.representative_info_by_address(
    address: zipcode,
    levels: 'country',
    roles: %w[legislatorUpperBody legislatorLowerBody]
  ).officials
rescue StandardError
  'You can find your representatives by visiting https://www.commoncause.org/take-action/find-elected-officials'
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_zipcode(zipcode)
  # if zipcode.nil?
  #   '00000'
  # elsif zipcode.length < 5
  #   zipcode.rjust(5, '0')
  # elsif zipcode.length > 5
  #   zipcode[0..4]
  # else
  #   zipcode
  # end
  # You can more succinctly handle all zipcode in the same case,
  # as seen below
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(phone_number)
  stripped_number = phone_number.gsub(/[^+\d]/, '')
  length = stripped_number.length
  bad_number = '0' * 10

  if length == 10
    stripped_number
  elsif length == 11 && stripped_number[0] == '1'
    stripped_number[1..]
  else
    bad_number
  end
end

puts 'EventManager Intialized!'

# content = File.read('event_attendees.csv')
# puts content

# lines = File.readlines('event_attendees.csv')
# lines.each_with_index do |line, index|
#   next if index.zero?

#   columns = line.split(',')
#   name = columns[2]
#   puts name
# end
# Again, the above can be better handling using an existing library

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

# contents.each do |row|
#   id = row[0]
#   name = row[:first_name]
#   zipcode = clean_zipcode(row[:zipcode])
#   legislators = legislators_by_zipcode(zipcode)

#   puts clean_phone_number(row[:homephone])

#   form_letter = erb_template.result(binding)

#   # save_thank_you_letter(id, form_letter)
# end
#
def parse_reg_date(csv_reg_date)
  reg_date = csv_reg_date.split(' ')[0].split('/').map do |d|
    d.rjust(2, '0')
  end
  reg_time = csv_reg_date.split(' ')[1].split(':').map do |d|
    d.rjust(2, '0')
  end
  date = Date.strptime(reg_date.join('/'), '%m/%d/%y')
  time = "#{reg_time.join(':')}:00"

  Time.new("#{date} #{time}")
end

registrations = contents.map do |row|
  reg = row[:regdate]
  parse_reg_date(reg)
end

hour_freq = registrations.map(&:hour).tally

day_freq = registrations.map do |reg|
  date = Date.parse(reg.to_s)
  date.wday
end

p hour_freq
p day_freq.tally
