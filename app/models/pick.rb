class Pick < ActiveRecord::Base
  belongs_to :answer
  belongs_to :alternative

  validates :answer,
    presence: true
  validates :alternative,
    presence: true
end
