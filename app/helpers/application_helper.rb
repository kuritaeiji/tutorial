module ApplicationHelper
  def full_title(title = '')
    if title.empty?
      "rails tutorial"
    else
      "#{title} | rails tutorial"
    end
  end
end
