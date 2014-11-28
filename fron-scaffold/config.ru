require "rubygems"
require "bundler/setup"
Bundler.require(:default)

require "rack"
require "middleman/rack"
require "rack/contrib/try_static"

use Rack::Head
use Rack::Deflater
use Rack::TryStatic,
    :root => "tmp",
    :urls => %w[/],
    :header_rules => [[:all, {'Cache-Control' => 'public, max-age=31536000'}]]

run lambda { |env|
  [
    200,
    {
      "Content-Type"  => "text/html",
      "Cache-Control" => "max-age=0"
    },
    File.open("tmp/index.html", File::RDONLY)
  ]
}
