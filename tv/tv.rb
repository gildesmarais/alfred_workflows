#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'json'

require_relative 'broadcasting'

page_source = open('http://www.klack.de/?typeID=-1&typeName=free')
doc = Nokogiri::HTML(page_source)

broadcasts = doc.css('table.broadcasts')
current_broadcast = broadcasts[0]

current_broadcastings = current_broadcast.css('tr').map do |broadcasting|
  station = broadcasting.css('.smallStation').text
  started_at = broadcasting.css('.smallTime').text
  name = broadcasting.css('.smallTitle').text
  url_path = broadcasting.css('.smallTitle > a').attr('href').value
  url = "http://klack.de/#{url_path}?popup=details"
  progress = broadcasting.css('.progressBar > div').attr('style').value.delete('width: ').delete('%')

  stars = 0
  if star_image = broadcasting.css('.smallTitle a > img')[0]
    stars = star_image.attr('src').delete('/templates/klack/images/rating').delete('.png')
  end

  Broadcasting.new(station, started_at, name, url, progress, stars)
end

puts({ items: Broadcasting.filter(current_broadcastings.map(&:to_alfred), ARGV[0]) }.to_json)
