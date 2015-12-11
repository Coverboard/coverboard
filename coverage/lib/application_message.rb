
require 'json'

class ApplicationMessage

    def set_timestamp( time = nil)
      if time.nil?
        @ts = Time.now.getutc
      else
        @ts = time
      end
    end

    def set_uid( uid )
      @uid = uid
    end

    def set_metrics( metrics )
      @metrics = metrics
    end

    def to_json
      msg = Hash.new
      msg['uid'] = @uid
      msg['ts']  = @ts
      msg['metrics'] = @metrics
      msg.to_json
    end

end