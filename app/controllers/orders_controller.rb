class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  
  def index
    @user_order = UserOrder.new
  end

  def create
    @user_order = UserOrder.new(order_params)
    if  @user_order.valid?
      pay_item
      @user_order.save
      redirect_to root_path
    else
      redirect_to item_orders_path
    end
  end

  private

  def order_params
    params.require(:user_order).permit(:postal_code, 
                                        :prefecture_id, 
                                        :city,
                                        :addresses, 
                                        :building, 
                                        :phone_number, 
                                        :price,
                                        )
                                        .merge(token: params[:token],
                                                item_id: params[:item_id],
                                                user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: Item.find(params[:item_id]).price, # 商品の値段
        card: order_params[:token],                # カードトークン
        currency: 'jpy'                            # 通貨の種類（日本円）
      )
  end
end
