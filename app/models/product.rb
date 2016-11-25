class Product < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  belongs_to :answer
  has_many :answers, inverse_of: :product
  has_many :batches, inverse_of: :product
  has_many :picks,        through: :answers
  has_many :alternatives, through: :picks
  has_many :questions,    through: :alternatives
  has_many :schools,      through: :answers
  has_many :contacts, through: :batches

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

      csv << School.to_title_row + questions.order(:number).distinct.map(&:statement) + ["Date"]
      answers.includes(school: [:region, :statute, :education], picks: [:alternative]).last([answers.length.pred, 0].max).each do |answer|
        entries = answer
          .picks
          .map(&:alternative)
          .sort_by(&:question_id)
          .map(&:statement)

        csv << (answer.school_to_row || []) + entries + [(I18n.l answer.created_at, format: :short)]
      end
    end
  end
end
