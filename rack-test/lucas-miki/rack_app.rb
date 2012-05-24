class RackApp
  def self.call(env)
    @request = Rack::Request.new(env)
    body = ['MIKIKE','asd','asd','asddsasd','asdasd']
    
    puts @request.path_info
    routes = {
      "text" => {'Content-Type'=>'text/plain', 'Body' => body.join},
      "json" => {'Content-Type'=>'application/json', 'Body' => body.to_json},
      "xml" => {'Content-Type'=>'text/xml', 'Body' => '<root>' + body.map{|item| '<value>'+item+'</value>'}.join("\n") + '</root>'}
    }
    route = routes.select{ |route| @request.path_info =~ Regexp.new("\/#{route}") }.values.first
    [200, {'Content-Type'=> route['Content-Type']}, [route['Body']] ]
  rescue
    [404, {'Content-Type'=> 'text/plain'}, ['Not found'] ]
  end
end
