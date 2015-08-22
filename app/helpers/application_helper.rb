module ApplicationHelper
  include GameHelper
  include ReviewHelper

  def markdown(text)
  	renderer = Redcarpet::Render::HTML.new(filter_html: true, no_links: true, no_images: true)
  	markdown = Redcarpet::Markdown.new(renderer, extensions = {})
  	markdown.render(text).html_safe
  end

  def header_link_class link
    return 'yellow' if current_page?(link)
    ''
  end

end