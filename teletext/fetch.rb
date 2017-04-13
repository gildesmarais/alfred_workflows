#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'json'

require_relative 'page100'

page = (ARGV[0] || 100).to_i
page_source = open("https://ard-text.de/mobil/#{page}")
doc = Nokogiri::HTML(page_source)

# TODO: add parsing for page != 100

puts Page100.new(doc).to_alfred.to_json
