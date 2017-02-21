class Order < ActiveRecord::Base
  after_create :set_order_status
  before_save :update_subtotal
  belongs_to :order_status
  has_many :cart_items

  def subtotal
	 cart_items.collect { |i| i.valid? ? (i.quantity.to_i * i.item_price.to_f) : 0 }.sum
  end

private

  def set_order_status
    self.order_status_id = 1 if self.order_status_id.nil?
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
