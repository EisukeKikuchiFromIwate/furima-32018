class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:index, :create]
  # before_action :move_root_path, only: :index

  def index
    if @item.order.present?
      redirect_to root_path
    elsif current_user.id == @item.user_id
      redirect_to root_path
    elsif
      @user_order = UserOrder.new
    else
      redirect_to user_session_path
    end
  end

  def create
    @user_order = UserOrder.new(order_params)
    if  @user_order.valid?
      pay_item
      @user_order.save
      redirect_to root_path
    else
      render :index
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

  # def move_root_path
  #   if current_user.id == @item.user_id
  #     redirect_to root_path
  #   end
  # end
end
