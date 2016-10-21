class Product < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  belongs_to :answer
  has_many :answers, inverse_of: :product
  has_many :picks,        through: :answers
  has_many :alternatives, through: :picks
  has_many :questions,    through: :alternatives
  has_many :schools,      through: :answers

  friendly_id :name, use: :slugged

  delegate :to_s, to: :name

  def long_persisted?
    persisted? and created_at + 10.minutes < Time.now
  end

  def to_csv
    CSV.generate do |csv|
      padding = [nil] * questions.distinct.count
      
      csv << [name] + padding
      csv << [] + padding

      csv << ["Colegio"] + questions.distinct.map(&:statement)
      answers.last(answers.length.pred).each do |answer|
        csv << [answer.school_name] + answer.picks.map(&:alternative).map(&:statement)
      end
    end
  end
end
