require 'net/http'

class Connector

  def initialize
    @post_ws = '/api/metrics'

    @user = 'user@socialtext.com'
    @pass = 'password'
    @host = 'localhost'
    @port = '80'
  end


  def set_auth credentials
    @user = credentials['user']
    @pass = credentials['password']
  end

  def set_auth_enabled enabled=false
    @auth_enabled = enabled
  end

  def set_connection conn
    @host = conn[:host]
    @port = conn[:port]
  end

  def set_payload payload
    @payload = payload
  end

  def set_endpoint endpoint
    @post_ws = endpoint
  end

  def response
    @response
  end

  def post
    req = Net::HTTP::Post.new(@post_ws, initheader = {'Content-Type' =>'application/json'})
    req.basic_auth @user, @pass if @auth_enabled
    req.body = @payload
    response = Net::HTTP.new(@host, @port).start {|http| http.request(req) }
    @response =  "Response #{response.code} #{response.message}:
          #{response.body}"
  end

end