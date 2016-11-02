require 'csv'

raise Exception.new("No file provided") unless ARGV[0]

base_district = District.find(13101)
base_statute  = Statute.first
base_educ     = Education.first

file = CSV::foreach ARGV[0] do |row|
  school = School.new district: base_district, statute: base_statute, education: base_educ, name: row.last
  school.contacts.build name: row.first, email: row[1]

  school.save if school.valid?
end