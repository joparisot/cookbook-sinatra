require_relative 'cookbook'
require_relative 'view'
require_relative 'service'
require 'nokogiri'
require 'open-uri'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
    @service = Letscookfrench.new
  end

  def list
    # list all the recipes, loop on recipes de cookbook and display
    @view.list(@cookbook)
  end

  def create
    # create a new recipe: call the recipe class and add to the cookbook (needed?)
    new_recipe_array = @view.add
    new_recipe = Recipe.new(new_recipe_array)
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # call the method from cookbook
    recipe_number = @view.remove - 1
    @cookbook.remove_recipe(recipe_number)
  end

  def mark_as_done
    index = @view.mark_as_done
    @cookbook.recipes[index - 1].done = "[X]"
    @cookbook.save_to_csv
  end

  def parse
    ingredient = @view.parse # appeler la methode view qui va recuperer l'ingredient
    difficulty_input = @view.which_difficulty
    ["Easy", "Very Easy", "Moderate", "Difficult"].include?(difficulty_input) ? difficulty_level = difficulty_input : difficulty_level = "all"
    array = @service.search(ingredient, difficulty_level)
    @view.return_result(array)
    @cookbook.add_recipe(Recipe.new(array[@view.which_number - 1]))
  end

end
