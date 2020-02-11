require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) do
    @category = Category.new(name: "Whatever")
    @product = Product.new(category: @category)
  end

  describe 'Validations' do
    it 'should create products' do
      expect(@product).to be_a Product
    end
    it 'returns true if all attributes are present' do
      @product.name = "Toy Truck"
      @product.quantity = 15
      @product.price = 5.99
      expect(@product.valid?).to be true
    end
    it 'returns false if name attribute is missing' do
      @product.name = nil
      @product.quantity = 5
      @product.price = 13
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to match_array(["Name can't be blank"])

    end
    it 'returns false if quantity attribute is missing' do
      @product.name = "Toy Truck"
      @product.quantity = nil
      @product.price = 13
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to match_array(["Quantity can't be blank"])
    end
    it 'returns false if price attribute is missing' do
      @product.name = "Toy Truck"
      @product.quantity = 5
      @product.price = nil
      expect(@product.valid?).to be false
    end
  end
end
