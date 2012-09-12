class RackApp
  def self.call(env)
    @request = Rack::Request.new(env)

    # /users/:id
    # /users/:user_id/comments/
    
    controller = case @request.path_info
    when /\/users\/\d+\/comments/
      "comments"
    when /\/users\/\d+/
      "users"
    else
      raise "invalid url"
    end
    
    method = @request.request_method
    
    response = run_controller_action( controller, method )
    
    [200, {'Content-Type'=> "application/json" }, [response] ]
  rescue => e
    puts "exception: #{e.message}"
    
    [404, {'Content-Type'=> 'text/plain'}, ['Not found'] ]
  end
  
  def self.get_id_from_path_info( path_info )
    path_info.match( /\/users\/(\d+)/ )[1].to_i
  end
  
  def self.run_controller_action( action, method )
    "naaaa"
  end
  
end
