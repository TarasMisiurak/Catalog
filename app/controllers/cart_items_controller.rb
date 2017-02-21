class CartItemsController < ApplicationController
  def create
  	@order = current_order
    @cart_item = @order.cart_items.new(cart_item_params)
    @order.save
    session[:order_id] = @order.id
  end

  def update
  	@order = current_order
    @cart_item = @order.cart_items.find(params[:id])
    @cart_item.update_attributes(cart_item_params)
    @cart_items = @order.cart_items
  end

  def destroy
  	@order = current_order
    @cart_item = @order.cart_items.find(params[:id])
    @cart_item.destroy
    @cart_items = @order.cart_items
  end

  private

  def cart_item_params
  	params.require(:cart_item).permit(:quantity, :post_id)
  end
end
