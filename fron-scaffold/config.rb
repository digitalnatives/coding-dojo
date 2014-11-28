require 'opal'
require 'fron'

after_configuration do
  Opal.paths.each do |p|
    sprockets.append_path p
  end
end

activate :livereload
activate :autoprefixer
activate :directory_indexes

ignore(/.*\.rb/)

set :build_dir, 'tmp'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :minify_html
  activate :asset_hash
end
