# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
$base_url = "https://apis.modernizacion.cl/dpa/"

###
# Helper module
###
module Cleaner
  def self.clean(object)
    send("clean_#{object['tipo']}", object) if object['tipo'] and not object['tipo'].empty?
  end

  def self.clean_region(region)
    {
      id:   region["codigo"],
      name: region["nombre"],
      lat:  region["lat"],
      lng:  region["lng"]
    }
  end

  def self.clean_provincia(provincia)
    {
      id:        provincia["codigo"],
      name:      provincia["nombre"],
      lat:       provincia["lat"],
      lng:       provincia["lng"],
      region_id: provincia["codigo_padre"]
    }
  end

  def self.clean_comuna(comuna)
    {
      id:          comuna["codigo"],
      name:        comuna["nombre"],
      lat:         comuna["lat"],
      lng:         comuna["lng"],
      province_id: comuna["codigo_padre"]
    }
  end
end

###
# Actual code
###
def bulk_insert(list)
  values = list.map {|value| "(" + value.attributes.values.map {|v| ActiveRecord::Base.sanitize v}[0...-2].join(",") + ", now(), now())" }
  ActiveRecord::Base.connection.execute "INSERT INTO #{list.first.class.table_name} (#{list.first.attributes.keys.join(",")}) VALUES " + values.join(",")
end

def seed(model, path)
  unless model.any? then
    list = HTTParty.get($base_url + path)
      .parsed_response
      .map {|obj| Cleaner.clean obj }
      .map {|obj| model.new obj }

    if list.map(&:valid?).all? then
      bulk_insert(list)
    else
      p list.map(&:errors)
    end
  end
end

seed(Region,   "regiones")
seed(Province, "provincias")
seed(District, "comunas")

Statute.create([
  {name: "Publico"},
  {name: "Subvencionado"},
  {name: "Privado"},
  {name: "Administración Delegada"}
])

Education.create([
  {name: "Especial"},
  {name: "Científico-Humanista"},
  {name: "De Adultos"},
  {name: "Técnico Profesional"}
])

###
# Dev-only fakes
###
if Rails.env.development? then
  unless School.any? then
    districts  = District.all
    statutes   = Statute.all
    educations = Education.all

    schools    = districts.map do |dist|
      school = School.new({
        district:  districts.sample,
        statute:   statutes.sample,
        education: educations.sample,

        name: Faker::Company.name,
        rbd:  Faker::Company.ein
      })
    end

    bulk_insert schools if schools.map(&:valid?).all?
  end
end