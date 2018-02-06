module ApplicationHelper
  def page_title
    if content_for?(:title)
      "#{content_for(:title)} | #{t("app.title")}"
    else
      t("app.title")
    end
  end
end
