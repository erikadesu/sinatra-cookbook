require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative 'models/recipe.rb'
require_relative 'cookbook.rb'

get '/' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  recipe = Recipe.new(params[:name],params[:description],  params[:ingredients], params[:instructions])
  cookbook.add_recipe(recipe)
  redirect to '/'
end

get '/recipes/:id' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  id = params['id'].to_i
  @recipe = cookbook.find(id)
  erb :show
end
