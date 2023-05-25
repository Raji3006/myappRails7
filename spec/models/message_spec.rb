require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { User.create(username: 'JohnDoe', email: 'john@example.com', phone_number: "1234567890", pincode: "123456", password: "password") }

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

    it 'creates the message' do
      message = Message.create(message: "This is test", user_id: user.id)
      expect(message).to be_valid
    end
    
    it 'deletes the message' do
      message = Message.create(message: 'Hello, world!', user_id: user.id)
  
      expect { message.destroy }.to change(Message, :count).by(-1)
    end

    it 'reads the message' do
      message = Message.create(message: "This is a test message", user_id: user.id)
      expect(Message.find_by_message("This is a test message")).to eq(message)
    end

    it 'updates the message' do
      message = Message.create(message: "This is a test message", user_id: user.id)
      new_content = 'Updated message content'
      message.update(message: new_content)
      expect(message.reload.message).to eq(new_content)
    end

    it 'returns all messages' do
      message1 = Message.create(message: 'Message 1', user_id: user.id)
      message2 = Message.create(message: 'Message 2', user_id: user.id)
  
      messages = Message.all
  
      expect(messages).to include(message1, message2)
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end

