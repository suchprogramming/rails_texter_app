class Message < ActiveRecord::Base
  belongs_to :user
  validates :body, :presence => true

  before_create :send_sms

  private

  def send_sms
    response = RestClient::Request.new(
      :method => :post,
      :url => "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TEST_TWILIO_ACCOUNT_SID']}/Messages.json",
      :user => ENV['TEST_TWILIO_ACCOUNT_SID'],
      :password => ENV['TEST_TWILIO_AUTH_TOKEN'],
      :payload => { :Body => body,
                    :To => to,
                    :From => from }
    ).execute
  end
end
