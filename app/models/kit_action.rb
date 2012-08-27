class InsufficientStockException < Exception; end

class KitAction < ActiveRecord::Base
  has_one :kits

  def self.assemble_kit(kit_id, n)
    k = Kit.find(kit_id)

    kls = KitLine.find_all_by_kit_id(k.id)

    kls.each { |kl|
      if kl.part.onhand < n*kl.count then
        raise InsufficientStockException.new("Not enough #{kl.part.id}: #{kl.part.description} on hand. Need #{n*kl.count}, only have #{kl.part.onhand}")
      end
    }

    ka = KitAction.new(:kit_id=>kit_id, :action=>"_alloc_", :n=>n)
    ka.save!

    kls.each { |kl|
      p = Part.find(kl.part_id)
      puts "Using up #{n*kl.count} of #{p.id}"
      p.onhand -= n*kl.count
      p.save
    }    
    ka = KitAction.new(:kit_id=>kit_id, :action=>"assemble", :n=>n)
    ka.save!

  end

  def self.capacity_for(kit_id)
    k = Kit.find(kit_id)

    kls = KitLine.find_all_by_kit_id(k.id)

    possible = {} # part => number of kits

    kls.each { |kl|
      m = (kl.part.onhand/kl.count).to_i
      # puts "#{kl.part_id} // #{m}"
      possible[kl.part_id] = m
    }

    # puts possible.keys.inspect
    maxima = possible.keys.sort_by { |a| possible[a] }
    maxima.each { |pid|
      p = Part.find(pid)
      puts "#{possible[pid]}\t #{p.id}, #{p.description} (#{p.group}/#{p.value})"
    }

  end

  def self.cost_per(kit_id)
    k = Kit.find(kit_id)
    prices = KitLine.find_all_by_kit_id(k.id).map { |kl| [kl.part.name, kl.count, kl.part.avg_price()*kl.count] }
  end
end
