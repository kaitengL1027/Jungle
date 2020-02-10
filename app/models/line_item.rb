class LineItem < ActiveRecord::Base
  
  belongs_to :order
  belongs_to :product

  monetize :item_price_cents, numericality: true
  monetize :total_price_cents, numericality: true

  # define_method :product do
  #   Product.find(:product_id)
  # end

  # def product
  #   Product.find(product_id)
  # end
end
