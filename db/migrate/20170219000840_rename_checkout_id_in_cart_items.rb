class RenameCheckoutIdInCartItems < ActiveRecord::Migration
  def change
  	rename_column :cart_items, :checkout_id, :order_id
  end
end
