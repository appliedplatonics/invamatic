#!./script/runner

#Usage: import_inventory "supplier" file.tsv

file = File.open(ARGV[1])
if !file then
  puts "Error opening input file: #{ARGV[1]}: $!"
  exit(1)
end

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

  h = {"supplier" => ARGV[0]}
  cols.each_with_index { |c_i, i| h[c_i] = vals[i] }

  money_cols = ["cost", "price"]
  money_cols.each { |m| 
    x = h[m].gsub(/\$/, "")
    h[m] = x.to_f
  }


  h_ol = h.clone()
  h_ol.delete("value")
  h_ol.delete("type")
  h_ol.delete("group")


  old_ol = OrderLine.find(:first, 
                          :conditions => { 
                            :supplier => h["supplier"], 
                            :supplier_partno => h["supplier_partno"],
                          })

  if old_ol then
    if h["part_id"] != old_ol.part_id then
      puts "Got new part with part_id=#{h["part_id"]}; existing with part_id=#{old_ol.part_id}"
      puts cols.map { |c| h[c] }.join("\t")

      h["part_id"] = old_ol.part_id
    end
  else
    puts "*** Missing part number for ***"
    puts cols.map { |c| h[c] }.join("\t")
  end
end

