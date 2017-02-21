class RenameCheckoutsToOrders < ActiveRecord::Migration
  def change
    rename_table :checkouts, :orders
  end
end
