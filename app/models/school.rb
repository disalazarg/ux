class School < ActiveRecord::Base
  extend FriendlyId

  has_one :province, through: :district
  has_one :region, through: :province
  belongs_to :district
  belongs_to :statute
  belongs_to :education
  has_many :contacts, inverse_of: :school

  friendly_id :name, use: :slugged

  delegate :to_s, to: :name
  delegate :name, to: :region, prefix: true, allow_nil: true
  delegate :name, to: :statute, prefix: true, allow_nil: true
  delegate :name, to: :education, prefix: true, allow_nil: true

  scope :by_region,    -> (param) { joins(:province).where(*cond_for_scope("region",   param)) }
  scope :by_district,  -> (param) { joins(:district).where(*cond_for_scope("district", param)) }
  scope :by_statute,   -> (param) { joins(:statute).where(*cond_for_scope("statute",  param)) }
  scope :by_education, -> (param) { joins(:education).where(*cond_for_scope("education", param)) }

  def self.to_title_row
    %w{Colegio RBD Región Dependencia Educación}
  end

  def to_row
    [name, rbd, region_name, statute_name, education_name]
  end

  private
  def self.cond_for_scope(name, param)
    param.try(:zero?) or param.try(:empty?) ?
      ["true"] :
      ["#{name}_id = ?", param]
  end
end
