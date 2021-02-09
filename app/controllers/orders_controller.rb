class OrdersController < ApplicationController
  before_action :order_params, :only=>[:create]
  before_action :filters, :only=>[:index]
  skip_before_action :verify_authenticity_token
  
  def create
    begin
      if ['BUY','SELL'].include?(order_params[:side])
        order = Order.create!(order_params)
        order_match = OrderMatch.new
        order_match.submit_order(order)
        if order_match.match?
          trade = order_match.trade!
          trade = order_params[:side] == 'SELL' ? trade[0] : trade[1]
        else 
          trade = order.app_hash
        end

        render status:200, :json=> trade and return 
      else
        render status:400, :json => {:message => "We are not supporting currently other than BUY and SELL"} and return
      end
    rescue Exception => e
      render status:400, :json => {:message => e.message} and return
    end
  end

  def index
    orders = Order.where(@filters).order("id #{@order_by}").page(@page).per(@page_size)
    total_orders = orders.collect{|o| o.app_hash}
    render status:200, :json=> total_orders
  end

  private

  def filters
    @filters = {}
    @filters[:side] = params[:side] if params[:side]
    @filters[:state] = params[:onlyCompletedOrders] && params[:onlyCompletedOrders].to_s == 'true' ? 'done' : 'pending'
    @page =  params[:page] || 1
    @page_size = params[:pageSize] || 10
    @order_by = params[:orderBy] || 'desc'
  end

  # Never order_params parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:side, :price, :volume)
  end
end
