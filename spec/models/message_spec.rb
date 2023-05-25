require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { User.create(username: 'John Doe', email: 'john@example.com') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      message = Message.new(
        message: 'This is a test message',
        user: user
      )
      expect(message).to be_valid
    end

    it 'is not valid without message' do
      message = Message.new(user: user)
      expect(message).not_to be_valid
      expect(message.errors[:message]).to include("can't be blank")
    end

    it 'is not valid without a user' do
      message = Message.new(message: 'This is a test message')
      expect(message).not_to be_valid
      expect(message.errors[:user]).to include("must exist")
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end

