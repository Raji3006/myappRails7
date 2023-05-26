require 'rails_helper'

RSpec.describe Message, type: :model do

  let(:user) { create(:user) }

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
    
    it 'deletes the message' do
      message = Message.create(message: 'Hello, world!', user_id: user.id)
  
      expect { message.destroy }.to change(Message, :count).by(-1)
    end

    it 'updates the message' do
      message = Message.create(message: "This is a test message", user_id: user.id)
      new_content = 'Updated message content'
      message.update(message: new_content)
      expect(message.reload.message).to eq(new_content)
    end

    it 'is not valid if it contains url' do
      message = Message.create(message: 'hello https://www.example.com/path/to/page?query=example&id=123', user_id: user.id)
      expect(message).not_to be_valid
      expect(message.errors[:message]).to include("cannot contain a URL")
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end

RSpec.describe TimeHelper, type: :helper do
  describe "#format_time" do
    it "formats time to 'Month - Year' format" do
      time = Time.utc(2023, 5, 15, 9, 51, 49)
      formatted_time = helper.format_time(time)
      expect(formatted_time).to eq("May - 2023")
    end
  end
end


