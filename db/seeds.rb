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

puts "Seeding geographic data"
seed(Region,   "regiones")
seed(Province, "provincias")
seed(District, "comunas")

puts "Seeding schools' contextual information"
Statute.create([
  {name: "Publico"},
  {name: "Subvencionado"},
  {name: "Privado"},
  {name: "Administración Delegada"}
]) unless Statute.any?

Education.create([
  {name: "Especial"},
  {name: "Científico-Humanista"},
  {name: "De Adultos"},
  {name: "Técnico Profesional"}
]) unless Education.any?

###
# Dev-only fakes
###
if Rails.env.development? or ENV['FORCE_SEED'] == "true" then
  puts "Seeding schools..."
  unless School.any? then
    pages      = District.page(1).total_pages
    statutes   = Statute.all
    educations = Education.all

    schools    = Array.new

    (1..pages).map do |i|
      districts = District.page i

      districts.each do |dist|
        schools << (1..10).map do
          School.new({
            district:  dist,
            statute:   statutes.sample,
            education: educations.sample,

            name: Faker::Company.name,
            rbd:  Faker::Company.ein
            })
        end
      end
    end
    
    bulk_insert schools.flatten.uniq(&:rbd)
  end

  puts "Seeding contacts..."
  unless Contact.any? then
    pages    = School.page(1).total_pages
    contacts = Array.new

    (1..pages).map do |i|
      schools = School.page i

      contacts << schools.map do |school|
        Contact.new({
          school: school,
          email: Faker::Internet.safe_email,
          name:  Faker::Name.name
          })
      end
    end

    bulk_insert contacts.flatten.uniq(&:email)
  end

  puts "Seeding users"
  unless User.any? then
    users = (1..20).map do
      pass = Faker::Internet.password

      User.new({
        email: Faker::Internet.safe_email,
        password: pass,
        password_confirmation: pass 
      })
    end

    bulk_insert users.uniq(&:email)
  end

  puts "Seeding polls"
  unless Poll.any? then
    poll = Poll.create({
      title: Faker::Lorem.sentence,
      finish: Date.new(2020,01,01),
      intro: Faker::Lorem.paragraph
    })
  else
    poll = Poll.first
  end

  unless Question.any? then
    questions = Array.new

    question = poll.questions.build number: 1, statement: "La extensión del producto le parece"
    question.alternatives << Alternative.new(number: 1, statement: "Breve")
    question.alternatives << Alternative.new(number: 2, statement: "Media")
    question.alternatives << Alternative.new(number: 3, statement: "Extensa")

    questions << question

    question = poll.questions.build number: 2, statement: "Los contenidos le parecen"
    question.alternatives << Alternative.new(number: 1, statement: "Muy útiles")
    question.alternatives << Alternative.new(number: 2, statement: "Algo útiles")
    question.alternatives << Alternative.new(number: 3, statement: "Poco útiles")

    questions << question

    question = poll.questions.build number: 3, statement: "Considera que este producto sirve para"
    question.alternatives << Alternative.new(number: 1, statement: "Informar: da a conocer el acontecer en educación")
    question.alternatives << Alternative.new(number: 2, statement: "Orientar: entrega información para ser llevadas a la práctica")
    question.alternatives << Alternative.new(number: 3, statement: "Introducir: explica nuevos conceptos y enfoques")

    questions << question

    question = poll.questions.build number: 4, statement: "La comprensión del producto es"
    question.alternatives << Alternative.new(number: 1, statement: "Sencilla")
    question.alternatives << Alternative.new(number: 2, statement: "Algo compleja")
    question.alternatives << Alternative.new(number: 3, statement: "Muy compleja")

    questions << question

    question = poll.questions.build number: 5, statement: "Encontrar la información que necesito es"
    question.alternatives << Alternative.new(number: 1, statement: "Fácil")
    question.alternatives << Alternative.new(number: 2, statement: "Medianamente fácil")
    question.alternatives << Alternative.new(number: 3, statement: "Difícil")

    questions << question

    questions.map(&:save) if questions.map(&:valid?).all?
  end

    puts "Seeding products"
  unless Product.any? then
    users = User.all
    questions = Question.includes(:alternatives).where(id: [1,3,4])

    products = (1..50).map do
      product = Product.new({
        user: users.sample,
        name: Faker::Commerce.product_name,
        link: Faker::Internet.url,
        description: Faker::Company.bs
      })

      answer = product.build_answer
      questions.map do |question|
        answer.picks.build alternative: question.alternatives.sample
      end

      product.save if product.valid?
    end
  end
end