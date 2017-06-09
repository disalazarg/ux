class Contact < ActiveRecord::Base
  extend FriendlyId

  belongs_to :school
  has_many :answers, inverse_of: :contact
  has_many :polleds, inverse_of: :contact
  has_many :polls, through: :polleds
  has_and_belongs_to_many :batches

  friendly_id :name, use: :slugged

  delegate :to_s, to: :name
  delegate :name, to: :school, prefix: true, allow_nil: true

  scope :polled, -> { joins(:polleds).where("NOW() - polleds.created_at < '3 months'::interval") }
  scope :unpolled, -> { joins("LEFT OUTER JOIN polleds ON polleds.contact_id = contacts.id").where("polleds.id IS NULL OR NOW() - polleds.created_at >= '12 months'::interval") }

  validates :email,
    uniqueness: true,
    format: { with: /@/ }

  def full_name
    "#{name}, #{school}"
  end
end
