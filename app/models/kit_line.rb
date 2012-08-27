class KitLine < ActiveRecord::Base
  belongs_to :kit
  has_and_belongs_to_many :parts

  def part
    Part.find(part_id)
  end
end
