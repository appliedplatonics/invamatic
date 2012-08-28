# Usage: ./script/runner ./script/howmany.rb kit_id
#
# Computes the total cost of a kit, given the average cost for the
# component items on-hand.
#
# Also uses the "times two" rule of thumb for generating MSRP; this
# may be lower than you want.

kit_id = ARGV[0].to_i

if (!ARGV[0]) then
  puts "Usage: ./script/runner ./script/howmuch.rb kit_id"
  puts "Where kit_id is one of:..."
  Kit.all.each { |k| puts "\t#{k.id}\t#{k.name}/#{k.description}" }
  exit
end

k = Kit.find(kit_id)
puts
puts "Kit: #{k.id} / #{k.name}"
puts

costs = KitAction.cost_per(kit_id)

costs.push(["assembly", 1, 1.00])

total = 0.0
costs.each { |name, n, cost|
  puts "\t$#{"%0.3f" % cost}\t#{n}\t#{name}"
  total += cost
}
puts "\t======"
puts "\t$#{"%0.2f" % total}\t\tTOTAL"
puts "\t$#{"%0.2f" % (2.0*total)}\t\tMSRP"
