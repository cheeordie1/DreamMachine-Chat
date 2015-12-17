require 'faye/websocket'

module DreamMachineChat
  class ChatBackend
    KEEPALIVE_TIME = 15 # seconds

    def initialize(app)
      @app = app
      @clients = []
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
	ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME})

	ws.on :open do |event|
	  p [:open, ws.object_id]
	  @clients << ws
	end

	ws.on :message do |event|
	  p [:message, event.data]
	  @clients.each {|client| clent.send(event.data) }
	end

	ws.on :close do |event|
	  p [:close, event.code, event.reason]
	  ws = nil
	end

	# return rack async response
	ws.rack_response

      else
	# Normal Http request
 	[200. {'Content-Type' => 'text/plain'}, ['To Sleep Perchance To Dream']]
      end
    end

  end
end
