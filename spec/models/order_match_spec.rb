require 'rails_helper'

RSpec.describe OrderMatch, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @order_match = OrderMatch.new
  end

  describe "#submit_order" do
    it "should push the order onto the buy order match" do
      buy = { "price": 124.8767, "side": "BUY", "volume": 12.6 }
      order = Order.create!(buy)
      @order_match.submit_order(order)

      @order_match.buy_map.size.should eq(1)
      @order_match.sell_map.size.should eq(0)
    end

    it "should push the order onto the sell order match" do
      sell = { "price": 124.8767, "side": "SELL", "volume": 12.6 }
      order = Order.create!(sell)
      @order_match.submit_order(order)

      @order_match.sell_map.size.should eq(1)
      @order_match.buy_map.size.should eq(0)
    end
  end

  describe "#match?" do
    it "should return false if buy is empty" do
      sell = { "price": 124.8767, "side": "SELL", "volume": 12.6 }
      order = Order.create!(sell)
      @order_match.submit_order(order)

      @order_match.match?.should be_falsey
    end

    it "should return false if sell is empty" do
      buy = { "price": 124.8767, "side": "BUY", "volume": 12.6 }
      order = Order.create!(buy)
      @order_match.submit_order(order)

      @order_match.match?.should be_falsey
    end

    it "should return false if sell does not match buy" do
      buy = { "price": 124.8767, "side": "BUY", "volume": 12.6 }
      sell = { "price": 129.8767, "side": "SELL", "volume": 12.6 }
      order_buy = Order.create!(buy)
      order_sell = Order.create!(sell)
      @order_match.submit_order(order_buy)
      @order_match.submit_order(order_sell)

      @order_match.match?.should be_falsey
    end

    it "should return true if sell matches buy" do
      buy = { "price": 124.8767, "side": "BUY", "volume": 12.6 }
      sell = { "price": 124.8767, "side": "SELL", "volume": 12.6 }

      order_buy = Order.create!(buy)
      order_sell = Order.create!(sell)

      @order_match.submit_order(order_buy)
      @order_match.submit_order(order_sell)

      @order_match.match?.should be_truthy
    end
  end

  describe "#trade!" do
    it "should remove the top-most buy and sell keys" do
      buy = { "price": 124.8767, "side": "BUY", "volume": 12.6 }
      sell = { "price": 124.8767, "side": "SELL", "volume": 12.6 }
      buy2 = { "price": 125.8767, "side": "BUY", "volume": 12.6 }
      

      order_buy = Order.create!(buy)
      order_buy2 = Order.create!(buy2)
      order_sell = Order.create!(sell)

      @order_match.submit_order(order_buy)
      @order_match.submit_order(order_buy2)
      @order_match.submit_order(order_sell)


      @order_match.buy_map.size.should eq(2)
      @order_match.sell_map.size.should eq(1)
    end
  end
end
