require 'csv'
require_relative "recipe"
require 'pry-byebug'

class Cookbook
  attr_reader :recipes

  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    CSV.foreach(csv_file) do |row|
      @recipes << Recipe.new({ name: row[0], description: row[1], cooking_time: row[2] })
    end
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    # puts the recipe in the CSV
    @recipes << recipe
    save_to_csv
  end


  def remove_recipe(recipe_id)
    # remove the recipe from the array and the load the array into the csv (ecraser)
    # what is the id? index? name? Let's do name for now
    # one problem is that in our array, we have cookbook objects, in the CSV we have rows
    # recipe = @recipes.select { |e| e.name.to_s == recipe_id}
    # pb is this is an array. y?
    # I store in local var recipe the element of the array @recipes of which the name is equal to recipe_id
    # @recipes.delete(recipe[0]) # prends l'object Recipe dans l'array recipe
    # CSV.open(@csv_file, 'w') do |csv|
    #   @recipes.each { |e| csv << [e.name, e.description] }

    @recipes.delete_at(recipe_id)
    save_to_csv
  end

  def save_to_csv
    CSV.open(@csv_file, 'w') do |csv|
      @recipes.each do |e|
        csv << [e.name, e.description, e.cooking_time, e.done, e.difficulty]
      end
    end
  end
end

# cookbook = Cookbook.new('lib/recipes.csv')
# # recipe = Recipe.new("test_add2", "description_add")
# # cookbook.add_recipe(recipe)
# cookbook.remove_recipe("test_add2")
# p cookbook.recipes





# add recipes and remove recipes will add and remove directly from the csv
# @recipes must be an array of recipes object
