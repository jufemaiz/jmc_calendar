require 'rubygems'
require 'sinatra'

require 'haml'
  set :haml, :format => :html5
require 'sass'
require 'coffee-script'

require 'linguistics'
Linguistics::use( :en )

# ----------------------------------
# Index - default year is 2011
# ----------------------------------
get '/' do
  @year = 2011
  haml :index
end

get %r{/(\d+)$} do
  @year = params[:captures][0].to_i
  haml :index
end

# ----------------------------------
# SCSS Custom Styling
# ----------------------------------

get '/css/styles.css' do
  sass :styles
end
