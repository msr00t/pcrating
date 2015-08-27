require 'cgi'
contents = File.read('GB.xml')
hash = Hash.from_xml(contents)
products = hash['product_catalog_data']['product']

new_array = []

products.each do |product|
  new_product = {}
  new_product[:name] = CGI.unescapeHTML(product['name']).gsub(/[^0-9A-Za-z'!-:’()–%&.,\/\[\]ø+•?;ō~öæ"‘  ]/, '').strip
  new_product[:url] = product['buyurl']
  new_product[:sku] = product['productsku']
  new_product[:original_name] = product['name']
  new_array << new_product
end

File.open("GB.json", "w") do |f|
  f.write(JSON.pretty_generate(new_array))
end