class AddPriceToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :price, :float
  end
end
