require 'nokogiri'

xml = Nokogiri::XML(File.open('bad.xml'))

xml.css('Media[ObjectUID]').each do |node| 
  puts node.attr('ObjectUID')
end
