# Solution adapted from
# https://stackoverflow.com/questions/20171539/how-to-apply-customized-bootstrap-messages-errors-to-devise
module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?
    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
      <div class="alert alert-danger alert-dismissable fade in">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <ul>#{messages}</ul>
      </div>
      HTML
    html.html_safe
  end
end