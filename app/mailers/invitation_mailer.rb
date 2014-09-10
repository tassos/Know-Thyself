class InvitationMailer < ActionMailer::Base
  default from: "knowthyself@eipieq.com"

  def invitation(address,survey,cc)
  	@survey = survey
	mail(to: address, cc: cc, bcc: 'knowthyself@eipieq.com', subject: 'Get to know youself with KnowThySelf application')
  end
end
