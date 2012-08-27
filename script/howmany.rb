# Usage: ./script/runner ./script/howmany.rb kit_id

kit_id = ARGV[0].to_i

if (!ARGV[0]) then
  puts "Usage: ./script/runner ./script/howmany.rb kit_id"
  puts "Where kit_id is one of:..."
  Kit.all.each { |k| puts "\t#{k.id}\t#{k.name}/#{k.description}" }
  exit
end

k = Kit.find(kit_id)
puts
puts "Kit: #{k.id} / #{k.name}"
puts
puts "Number of kits produceable, given component X"

puts "N\tX"

KitAction.capacity_for(kit_id)
