#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'json'

require_relative 'broadcasting'

page_source = open('https://www.klack.de/fernsehprogramm/was-laeuft-gerade/0/-1/free.html')
doc = Nokogiri::HTML(page_source)

broadcasts = doc.css('table.broadcasts')
current_broadcast = broadcasts[0]

current_broadcastings = current_broadcast.css('tr')[1..-1].map do |broadcasting|
  station = broadcasting.css('.station a img').last.attr('alt')
  starts_at = broadcasting.css('.time').last.text.strip
  name = broadcasting.css('.content > a').last.text

  url_path = broadcasting.css('.details .content > a').last.attr('href')
  url = "https://klack.de#{url_path}?popup=details"

  Broadcasting.new(station, nil, "#{name} [#{starts_at}]", url, nil, nil)
end

puts({ items: Broadcasting.filter(current_broadcastings.map(&:to_alfred), ARGV[0]) }.to_json)
