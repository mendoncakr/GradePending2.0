module Rack
	class Health
		HEADERS = {'Content-Type' => 'text/plain'}

		def initialize(app, options={})
			@app = app
			if options[:routes] && options[:response]
				@headers = options[:headers] || HEADERS
				@routes = options[:routes]
				@response = options[:response]
			else
				raise ArgumentError.new 'Rack::Health requires at least one route and a response'
			end
		end

		def call(env)
      if @routes.include? env['PATH_INFO']
        [200, @headers, @response]
      else
        @app.call(env)
      end
    end
	end
end
