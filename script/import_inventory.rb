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
    if (!h["part_id"].empty? && h["part_id"] != old_ol.part_id) then
      puts "Part ID conflict; found old entry with ID #{old_old.part_id} (OL##{old_ol.id}), but specified #{h["part_id"]}"
    end
    h["part_id"] = old_ol.part_id
  end

  ol = OrderLine.new(h_ol)
  ol.save!

  puts "OL: #{ol.supplier_desc} => #{ol.id} => #{ol.part_id}"

  p = Part.find_by_id(h["part_id"])
  if !p then
    h_part = h.clone()

    fields_to_delete = [
                        "supplier", 
                        "supplier_partno", 
                        "manu_partno",
                        "price", 
                        "cost",
                        "part_id",
                        "supplier_desc",
                        "quantity",
                       ]

    field_map = {  # import colname => part colname
      "part_id" => "id",
      "supplier_desc" =>  "description", 
      "supplier_desc" =>  "name", 
    }

    field_map.each { |f_there, f_here| 
      h_part[f_here] = h[f_there]; 
    }

    fields_to_delete.each { |f| h_part.delete(f) }
    p = Part.new(h_part)
    p.description = h["supplier_desc"]
    p.onhand = 0
    p.id = h["part_id"]
    p.save!
    puts "PART #{p.id} vs #{h["part_id"]}"
  end

  p.onhand += h["quantity"].to_i
  p.order_lines.push(ol)
  p.save!
end
