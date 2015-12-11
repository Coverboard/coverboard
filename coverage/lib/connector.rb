require 'net/http'

class Connector

  attr_accessor :payload
  attr_accessor :endpoint
  attr_accessor :response
  attr_accessor :user
  attr_accessor :pass
  attr_accessor :host
  attr_accessor :port
  attr_accessor :auth_enabled

  def initialize
    @endpoint = '/api/metrics'

    @user = 'admin@helpling.com'
    @pass = 'cleanmeup'
    @host = 'localhost'
    @port = '3000'
    @auth_enabled = false
  end

  def post
    req = Net::HTTP::Post.new(@endpoint, initheader = {'Content-Type' =>'application/json'})
    req.basic_auth @user, @pass if @auth_enabled
    req.body = @payload
    response = Net::HTTP.new(@host, @port).start {|http| http.request(req) }
    @response =  "Response #{response.code} #{response.message}:
          #{response.body}"
  end

end