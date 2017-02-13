require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
# require_relative 'lib/cookbook'
# require_relative 'lib/controller'
# require_relative 'lib/router'
set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative "lib/cookbook"

get '/' do
  erb :index
  @cookbook = Cookbook.new("lib/recipes.csv")
  # @controller = Controller.new(@cookbook)
  # @view = View.new
end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "the username is #{params[:username]}"
end
