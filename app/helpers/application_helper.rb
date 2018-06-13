module ApplicationHelper
  def page_title
    if content_for?(:title)
      "#{content_for(:title)} | #{t("app.title")}"
    else
      t("app.title")
    end
  end

  def contact_link
    return nil if ENV["CONTACT_LINK"].blank? || !signed_in?

    ENV["CONTACT_LINK"].gsub("${account_id}", current_user.account_id.to_s).gsub("${name}", current_user.name)
  end
end
