
require 'json'

class ApplicationMessage

    attr_accessor :metrics
    attr_accessor :uid
    attr_accessor :ts

    def initialize
      @ts = Time.now.getutc
    end

    def to_json
      msg = Hash.new
      msg[:uid] = @uid
      msg[:ts]  = @ts
      msg[:metrics] = @metrics
      msg.to_json
    end

end