require 'algorithms'
$buy_map = Containers::CRBTreeMap.new
$sell_map = Containers::CRBTreeMap.new

class Order < ApplicationRecord
  enum state: {:pending => 'pending', :done => 'done'}
  enum side: {:BUY => 'BUY', :SELL => 'SELL'}


  def submit_order
    if self.side == 'BUY'
      $buy_map.push(self, true)
    else
      $sell_map.push(self, true)
    end
    return {
      orderId: id,
      status: state,
      price: price,
      volume: volume,
      side: side,
    }
  end


  def match?(other)
    price_match = if side == 'BUY' && other.side == 'SELL'
      price >= other.price
    else
      price <= other.price
    end
    puts "==-=-=- price_match #{price_match}"
    puts "==-=-=- volume #{volume}"
    volume == other.volume &&
      price_match
  end

  def app_hash
    return {
      orderId: id,
      status: state,
      price: price,
      volume: volume,
      tradedVolume: traded_volume || 0
    }
  end

end
