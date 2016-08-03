# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
$base_url = "https://apis.modernizacion.cl/dpa/"
$rand     = Random.new

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
def clean_for_bulk(object)
  object.id ? object.attributes : object.attributes.reject {|k,v| k == :id or k == "id" }
end

def bulk_insert(list)
  values = list.map {|value| "(" + clean_for_bulk(value).values.map {|v| ActiveRecord::Base.sanitize v}[0...-2].join(",") + ", now(), now())" }
  ActiveRecord::Base.connection.execute "INSERT INTO #{list.first.class.table_name} (#{clean_for_bulk(list.first).keys.join(",")}) VALUES " + values.join(",")
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
    pages      = District.page(1).total_pages
    statutes   = Statute.all
    educations = Education.all

    (1..pages).map do |i|
      districts = District.page i

      districts.each do |dist|
        schools = (1..10).map do
          School.new({
            district:  dist,
            statute:   statutes.sample,
            education: educations.sample,

            name: Faker::Company.name,
            rbd:  Faker::Company.ein
          })
        end

        bulk_insert schools.select {|s| s.valid? }
      end
    end
  end

  unless Contact.any? then
    pages = School.page(1).total_pages

    (1..pages).map do |i|
      schools = School.page i

      contacts = schools.map do |school|
        Contact.new({
          school: school,
          email: Faker::Internet.safe_email,
          name:  Faker::Name.name
        })
      end

      bulk_insert contacts.select {|s| s.valid? }
    end
  end
end