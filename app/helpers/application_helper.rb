# Main helper module, includes the other helper modules and also holds markdown
# functionality.
# TODO: Pull Markdown out into a service
module ApplicationHelper
  include GameHelper
  include ReviewHelper

  def markdown(text)
    renderer_options = { filter_html: true, no_links: true, no_images: true }
    markdown_extensions = {}

    renderer = Redcarpet::Render::HTML.new(renderer_options)
    markdown = Redcarpet::Markdown.new(renderer, markdown_extensions)
    markdown.render(text).html_safe
  end

  def header_link_class(link)
    return 'yellow' if current_page?(link)
    ''
  end
end
