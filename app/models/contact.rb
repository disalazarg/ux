class Contact < ActiveRecord::Base
  extend FriendlyId

  belongs_to :school

  friendly_id :name, use: :slugged
end
