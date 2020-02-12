require 'rails_helper'

RSpec.describe User, type: :model do
  
  before(:each) do
    @user = User.new
  end

  describe 'Signup Form Validation' do

    it 'is true if all attributes are valid' do
      @user.first_name = 'Smith'
      @user.last_name = 'Paul'
      @user.email = 'abc@gmail.com'
      @user.password = '11111111'
      @user.password_confirmation = '11111111'
      expect(@user.valid?).to be true
    end

    it 'is false if first_name attribute is not valid' do
      @user.first_name = nil
      @user.last_name = 'Paul'
      @user.email = 'abc@gmail.com'
      @user.password = '11111111'
      @user.password_confirmation = '11111111'
      expect(@user.valid?).to be false
    end

    it 'is false if last_name attribute is not valid' do
      @user.first_name = 'Paul'
      @user.last_name = nil
      @user.email = 'abc@gmail.com'
      @user.password = '11111111'
      @user.password_confirmation = '11111111'
      expect(@user.valid?).to be false
    end

    it 'is false if email already in database' do
      @user1 = User.new
      @user1.first_name = 'Paul'
      @user1.last_name = 'Smith'
      @user1.email = 'abc@gmail.com'
      @user1.password = '11111111'
      @user1.password_confirmation = '11111111'
      expect(@user1.valid?).to be true
      @user1.save

      @user2 = User.new
      @user2.first_name = 'Paul'
      @user2.last_name = 'Smith'
      @user2.email = 'Abc@gmail.com'
      @user2.password = '11111111'
      @user2.password_confirmation = '11111111'
      expect(@user2.valid?).to be false
    end

    it 'is false if password attribute is not the same as password_confirmation' do
      @user.first_name = 'Paul'
      @user.last_name = 'Smith'
      @user.email = 'abc@gmail.com'
      @user.password = '11111111'
      @user.password_confirmation = '1000000'
      expect(@user.valid?).to be false
    end
  end

  describe '.authenticate_with_credentials' do
    
    it 'returns user if logged in with the exact same email and password' do
      @user1 = User.new
      @user1.first_name = 'Samual'
      @user1.last_name = 'Jackson'
      @user1.email = 'sjackson@gmail.com'
      @user1.password = '123456'
      @user1.password_confirmation = '123456'
      @user1.save

      @user2 = User.authenticate_with_credentials('sjackson@gmail.com', '123456')
      expect(@user2.email).to eq('sjackson@gmail.com')
    end

    it 'returns nil if logged in with the wrong password' do
      @user1 = User.new
      @user1.first_name = 'Samual'
      @user1.last_name = 'Jackson'
      @user1.email = 'sjackson@gmail.com'
      @user1.password = '123456'
      @user1.password_confirmation = '123456'
      @user1.save

      @user2 = User.authenticate_with_credentials('sjackson@gmail.com', '1234567')
      expect(@user2).to be nil
    end

    it 'returns nil if logged in with the wrong email' do
      @user1 = User.new
      @user1.first_name = 'Samual'
      @user1.last_name = 'Jackson'
      @user1.email = 'sjackson@gmail.com'
      @user1.password = '123456'
      @user1.password_confirmation = '123456'
      @user1.save

      @user2 = User.authenticate_with_credentials('sjackson1@gmail.com', '123456')
      expect(@user2).to be nil
    end

    it 'returns user if logged in with leading and trailing case-insensitive email' do
      @user1 = User.new
      @user1.first_name = 'Samual'
      @user1.last_name = 'Jackson'
      @user1.email = 'sjackson@gmail.com'
      @user1.password = '123456'
      @user1.password_confirmation = '123456'
      @user1.save

      @user2 = User.authenticate_with_credentials('    sjaCKSon@gmail.com   ', '123456')
      expect(@user2.email).to eq('sjackson@gmail.com')
    end
  end
end
