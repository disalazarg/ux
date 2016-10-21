class Polled < ActiveRecord::Base
  belongs_to :poll
  belongs_to :contact
end
