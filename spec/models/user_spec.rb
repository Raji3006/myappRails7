require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(
        username: 'John_Doe',
        email: 'john@example.com',
        password: 'password',
        phone_number: '9090909090',
        pincode: '044040'
      )
      expect(user).to be_valid
    end

    it 'only allows letters, numbers, and underscores' do
      user = User.new(username: 'r@123', email: 'john@example.com', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("only allows letters, numbers, and underscores")
    end

    it 'is not valid without an email' do
      user = User.new(username: 'JohnDoe', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is not valid without a password' do
      user = User.new(username: 'John_Doe', email: 'john@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

  end
end

