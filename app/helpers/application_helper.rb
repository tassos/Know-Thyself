module ApplicationHelper
  def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :warning then "alert alert-warning"
        when :alert then "alert alert-danger"
        else "alert alert-info"
    end
  end
end
