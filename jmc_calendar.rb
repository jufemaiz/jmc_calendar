# frozen_string_literal: true

require 'rubygems'
require 'sinatra'

require 'haml'
require 'sass'
require 'coffee-script'

require 'linguistics'

set :haml, format: :html5
Linguistics.use(:en)

# ----------------------------------
# Index - This uses the current date
# ----------------------------------
get '/' do
  # TODO: use of UTC over server timezone; Localised timezone support
  params[:tz] ||= 0
  # /TODO

  @today = Date.today
  @year = @today.year
  @start = @today

  # Manage start and end of calendar
  @start = if @today.month == 1
             Date.new(@today.year - 1, 12, 1)
           else
             Date.new(@today.year, @today.month - 1, 1)
           end
  @finish = @start >> 12

  haml :index
end

# ----------------------------------
# Year - calendar for a particular year
# ----------------------------------
get %r{\/(\d+)} do
  # TODO: use of UTC over server timezone; Localised timezone support
  params[:tz] ||= 0
  # /TODO
  @year = params[:captures][0].to_i
  @today = Date.today
  @start = Date.new(@year, 1, 1)
  @finish = Date.new(@year, 12, 31)

  haml :annual
  # haml :index
end

# ----------------------------------
# SCSS Custom Styling
# ----------------------------------

get '/css/styles.css' do
  sass :styles
end
