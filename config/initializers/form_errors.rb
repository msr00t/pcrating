ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  "<div class=\"error\"></div>#{html_tag}".html_safe
end