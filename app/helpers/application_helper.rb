module ApplicationHelper
  def full_title(yielded_title)
    if yielded_title.empty?
      'rails turorial'
    else
      "#{yielded_title} | rails tutorial"
    end
  end
end
