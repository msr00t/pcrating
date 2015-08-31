require 'base64'
require 'net/http'

# Controller for the https image proxy
class ImageProxyController < ActionController::Base
  def get
    url = URI.parse(Base64.decode64(params[:url]))
    image = Net::HTTP.get_response(url)
    send_data image.body, type: image.content_type, disposition: 'inline'
  end
end