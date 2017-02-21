class AddCheckoutsReferenceToCartItems < ActiveRecord::Migration
  def change
    add_reference :cart_items, :checkout, index: true, foreign_key: true
  end
end
