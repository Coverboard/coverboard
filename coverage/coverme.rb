#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'

require './lib/application_message'
require './lib/connector'

# TODO change for a command line parameter
INDEX_HTML_LOC = '/Users/lautaromazzitelli/Projects/hassle/coverage/index.html'
UID = 'myCoveredApplication'
TIMESTAMP = nil

def parse_index_file

  prefix = 'coverage-'

  metrics = Hash.new
  doc = File.open(INDEX_HTML_LOC ) { |f| Nokogiri::HTML(f) }
  nodes = doc.xpath('//*[@id="content"]/div/h2')
  nodes.each do |node|
    key =  (prefix + node.xpath('span[@class="group_name"]').inner_html).gsub(' ','-').downcase
    value = node.xpath('span[@class="covered_percent"]/span').inner_html.chomp('%').to_f
    metrics[key] = value
  end

  metrics
end

def create_message metrics
    app_message = ApplicationMessage.new
    app_message.set_uid UID
    app_message.set_timestamp TIMESTAMP
    app_message.set_metrics metrics
    return app_message.to_json
end

def send_to_api msg
  connector = Connector.new
  connector.set_payload msg
  connector.post
  puts connector.response
end

## Parse command line parameters
# TODO
def parse_command_line
  puts INDEX_HTML_LOC  + ' parsed!'
end

## Main entry point
def main
  parse_command_line
  msg = create_message parse_index_file
  send_to_api msg
end

main