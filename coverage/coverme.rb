#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'

# TODO change for a command line parameter
INDEX_HTML_LOC = '/Users/lautaromazzitelli/Projects/hassle/coverage/index.html'

def parse_index_file

  doc = File.open(INDEX_HTML_LOC ) { |f| Nokogiri::HTML(f) }
  
  nodes = doc.xpath('//*[@id="content"]/div/h2')

  nodes.each do |node|
    puts node.xpath('span[@class="group_name"]').inner_html
    puts node.xpath('span[@class="covered_percent"]/span').inner_html
  end
end

## Parse command line parameters
# TODO
def parse_command_line
  puts INDEX_HTML_LOC  + ' parsed!'
end

## Main entry point
def main
  parse_command_line
  parse_index_file
end

main