#!/usr/bin/ruby
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'uri'
require 'ftools'

url = 'http://www.hubblesite.org/gallery/wallpaper/'

html = Nokogiri::HTML(open(url))

html.search("//a[@class='icon wallpaper']/img").each do |link|
    title = link['alt']
    image_url= link['src'].scan(/(.*)-wallpaper_thumb\.jpg/i).flatten.first + '-1280_wallpaper.jpg'
    puts "#{title} @ #{image_url}"
    open(image_url, "r") do |infile|
        File.open("#{title}.jpg", "wb") do |outfile|
            while not (buffer = infile.read(10240)).nil?
                outfile.write(buffer)
            end
        end
    end
end
