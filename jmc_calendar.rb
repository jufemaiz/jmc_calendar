require 'rubygems'
require 'sinatra'

require 'haml'
  set :haml, format: :html5
require 'sass'
require 'coffee-script'

require 'linguistics'
Linguistics::use( :en )

# ----------------------------------
# Index - This uses the current date
# ----------------------------------
get '/' do
  # TODO: use of GMT over server timezone; Localised timezone support
  params[:tz] ||= 0
  # /TODO

  @today = Date.today
  @year = @today.year
  @start = @today
  # Manage start and end of calendar
  # Start
  if @today.month == 1
    @start = Date.new(@today.year - 1,12,1)
  else
    @start = Date.new(@today.year,@today.month-1,1)
  end
  @end = @start>>(12)

  haml :index
end

# ----------------------------------
# Year - calendar for a particular year
# ----------------------------------
get %r{\/(\d+)} do
  # TODO: use of GMT over server timezone; Localised timezone support
  params[:tz] ||= 0
  # /TODO
  @year = params[:captures][0].to_i
  haml :annual
end

# ----------------------------------
# SCSS Custom Styling
# ----------------------------------

get '/css/styles.css' do
  sass :styles
end
