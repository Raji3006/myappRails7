class Message < ApplicationRecord
  belongs_to :user

  validates :message, presence: true
  validate :no_url_format

  private

  def no_url_format
    return unless message.present?

    url_regex = /(http[s]?:\/\/(?:www\.)?\w+\.\w+(?:\.\w+)?(?:\/\S*)?)/i
    errors.add(:message, 'cannot contain a URL') if message.match(url_regex)
  end
end