# Usage: import_kits.rb foo.tsv

# foo.tsv needs to have a part_ids column, containing comma-delimited part ids.
#
# This is a pretty awkward specification format, and should be reconsidered.  For now, it looks like this:
#
#"name"	"description"	"part_ids"
# "Analog Shield v0.1"	"Analog Input Shield"	"504,1;75,6;20,6;1,1;24,1;600,1"
#
# Where the Analog Input Shield is made up of 1x504, 6x75, 6x20, etc.
#
# This is, of course, hideous and user-unfriendly.  XXX TODO Make it a more pleasant input format.

file = File.open(ARGV[0])

headline = file.gets()
headline.chomp!
cols = headline.split("\t")
cols.map! { |x| x && x.gsub(/^"(.*)"$/, '\1');  }

puts cols.inspect()

while (l = file.gets()) do
  next if l.match(/^\s*$/)
  l.chomp!
  vals = l.split("\t")
  vals.map! { |x| x && x.gsub(/^"?(.*)"$/, '\1');  }

  h = {}

  cols.each_with_index { |c_i, i| h[c_i] = vals[i] }

  part_tags = h["part_ids"].split(";")
  parts = part_tags.map { |s| s.split(",").map(&:to_i) }

  h.delete("part_ids")
  k = Kit.new(h)
  k.save!

  parts.each { |pid,n|
    kl = KitLine.new(:kit_id =>k.id, :part_id =>pid, :count => n)
    kl.save!
  }
end
