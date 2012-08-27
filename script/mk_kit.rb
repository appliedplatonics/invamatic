# Usage: ./script/runner kit_id number_to_run

kit_id = ARGV[0].to_i
number = ARGV[1].to_i

if (!ARGV[0] || !ARGV[1]) then
  puts "Usage: ./script/runner ./script/mk_kit.rb kit_id N"
  puts "Where kit_id is one of:..."
  Kit.all.each { |k| puts "\t#{k.id}\t#{k.name}/#{k.description}" }
  exit
end

k = Kit.find(kit_id)
puts "You\'ve built #{number} copies of kit #{k.name}/#{k.description}, right?"
puts "Press enter to continue..."
$stdin.gets

KitAction.assemble_kit(kit_id, number)
