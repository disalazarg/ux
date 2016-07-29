# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
$base_url = "https://apis.modernizacion.cl/dpa/"

unless Region.any? then
  regions = HTTParty.get($base_url + "regiones")
    .parsed_response
    .map {|region| Region.new region }

  if regions.map(&:valid?).all? then
    Region.transaction do
      regions.map(&:save)
    end
  end
end