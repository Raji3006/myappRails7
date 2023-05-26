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

    it 'is not valid with a duplicate email' do
      existing_user = User.create(username: "example", email: 'existing@example.com', password: 'password', phone_number: '9090909090', pincode: '123456')
      new_user = User.new(email: 'existing@example.com', password: 'password')
      new_user.valid?
  
      expect(new_user.errors[:email]).to include('has already been taken')
    end
    
    it 'deletes the user' do
    user = User.create(username: 'JohnDoe', email: 'john@example.com', password: 'password', phone_number: '9090909090', pincode: '123456')

    expect { user.destroy }.to change(User, :count).by(-1)
    end

    it 'is not valid without a valid pincode' do
      user = User.create(username: 'JohnDoe', email: 'johndoe@example.com', pincode: '123')
      expect(user).not_to be_valid
      expect(user.errors[:pincode]).to include("is the wrong length (should be 6 characters)")
    end

    it 'is not valid without a valid phone number' do
      user = User.create(username: 'JohnDoe', email: 'johndoe@example.com', phone_number: '123')
      expect(user).not_to be_valid
      expect(user.errors[:phone_number]).to include("is the wrong length (should be 10 characters)")
    end
  end
end

