class Part < ActiveRecord::Base
  has_many :order_lines
  has_and_belongs_to_many :kit_line

  def active_order_lines
    # TODO make this return only the active order lines
    return order_lines
  end

  def avg_price()
    # TODO make this work its way back through time, returning the
    # weighted cost by number on-hand per order.
    s = active_order_lines.map(&:cost).sum
    n = active_order_lines.map(&:quantity).sum
    return (s.to_f/n).round(2)
  end
end
