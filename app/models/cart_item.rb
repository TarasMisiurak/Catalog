class CartItem < ActiveRecord::Base
  belongs_to :post
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :order_id, uniqueness: { scope: :post_id, message: "Already in cart" }
  validate :post_present
  validate :order_present

  before_save :finalize

  def item_price
  	if persisted?
  		self[:item_price]
  	else
  		post.price
  	end
  end

  def total_price
  	item_price * quantity
  end

  private

  def post_present
  	if post.nil?
  		errors.add(:post, 'Post error')
  	end
  end

  def order_present
  	if order.nil?
  		errors.add(:order, 'Order missing')
  	end
  end

  def finalize
  	self[:item_price] = item_price
  	self[:total_price] = quantity * self[:item_price]
  end

end
