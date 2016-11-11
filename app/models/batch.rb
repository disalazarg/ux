class Batch < ActiveRecord::Base
  belongs_to :product
  has_and_belongs_to_many :contacts

  scope :recent, -> { where("NOW() - batches.created_at < '3 months'::interval") }
end
