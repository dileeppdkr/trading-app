require 'algorithms'
$buy_map = Containers::CRBTreeMap.new
$sell_map = Containers::CRBTreeMap.new

class OrderMatch

  # attr_accessor :buy_map, :sell_map

  # def initialize
  #   @buy_map = Containers::CRBTreeMap.new
  #   @sell_map = Containers::CRBTreeMap.new
  # end

  def submit_order(order)
    if order.side == 'BUY'
      $buy_map.push(order, true)
    else
      $sell_map.push(order, true)
    end
  end

  def match?
    puts $buy_map.size
    puts $sell_map.size
    return false if $buy_map.size == 0 || $sell_map.size == 0
    $sell_map.min_key.match? $buy_map.max_key
  end

  def trade!
    sell = $sell_map.max_key
    buy = $buy_map.min_key

    sell.update_attributes(state: 'done', volume: 0, traded_volume:  sell.volume)
    buy.update_attributes(state: 'done', volume: 0, traded_volume:  buy.volume)
    $sell_map.delete(sell)
    $buy_map.delete(buy)

    return [sell.app_hash, buy.app_hash]
  end

end