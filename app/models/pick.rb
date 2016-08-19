class Pick < ActiveRecord::Base
  belongs_to :answer
  belongs_to :alternative
end
