class Kit < ActiveRecord::Base
  has_and_belongs_to_many :kit_actions
  has_many :kit_lines  
end
