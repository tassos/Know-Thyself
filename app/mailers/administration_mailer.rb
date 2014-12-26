class AdministrationMailer < ActionMailer::Base
  default from: "knowthyself@eipieq.com"

  def admin_links(survey)
  	@survey = survey
	mail(to: @survey.user.email, bcc: 'knowthyself@eipieq.com', subject: 'Administration of your newly created survey')
  end
end
