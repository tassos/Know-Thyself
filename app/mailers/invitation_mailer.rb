class InvitationMailer < ActionMailer::Base
  default from: "knowthyself@eipieq.com"

  def invitation(address,survey,cc)
	mail(to: address, cc: cc, bcc: 'knowthyself@eipieq.com', subject: 'I want to know about myself')
  end
end
