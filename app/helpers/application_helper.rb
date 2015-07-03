module ApplicationHelper
  def markdown(text)
  	renderer = Redcarpet::Render::HTML.new(filter_html: true, no_links: true, no_images: true)
  	markdown = Redcarpet::Markdown.new(renderer, extensions = {})
  	markdown.render(text).html_safe
  end
end