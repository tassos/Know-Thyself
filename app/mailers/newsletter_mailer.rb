class NewsletterMailer < ActionMailer::Base
  default from: "knowthyself@eipieq.com"

  def subscribe(address)
  	mail(to: address, subject: 'You are subscribed to the KnowThySelf Newsletter!')
  end

  def unsubscribe(address)
  	mail(to: address, subject: 'You have un-subscribed from the KnowThySelf Newsletter!')
  end
end
