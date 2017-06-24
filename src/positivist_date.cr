require "kemal"
require "./positivist_date/*"

MONTHS = ["Moses", "Homer", "Aristotle", "Archimedes", "Caesar", "Saint Paul", "Charlemagne", "Dante", "Gutenberg", "Shakespeare", "Descartes", "Frederick", "Bichat"]
WEEK_DAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
START_YEAR = 1789 - 1 # year one is 1789 for the positivist calendar

get "/" do |env|
  date_string = env.params.query["date"]?
  date = Time.parse(date_string, "%F") if date_string
  date ||= Time.now
  doy = date.day_of_year
  "#{positivist_date_for(doy)}, #{date.year - START_YEAR}"
end

def positivist_date_for(day_of_year)
  if day_of_year == 365
    return "Day of the Dead"
  end

  if day_of_year == 366
    return "Women's Day"
  end

  month = day_of_year / 28
  day = day_of_year - month  * 28

  weekday = WEEK_DAYS[(day - ((day / 7) * 7)) - 1]

  "#{weekday}, #{MONTHS[month]} #{day}"
end

Kemal.run
