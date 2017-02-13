class Recipe
  attr_reader :name, :description, :cooking_time, :difficulty
  attr_accessor :done
  def initialize(args)
    fail "Name is mandatory" unless args[:name]

    @name = args[:name]
    @description = args[:description]
    @cooking_time = args[:cooking_time]
    @done = "[ ]"
    @difficulty = args[:difficulty]
  end
end

# recipe = Recipe.new("test", "description")
# puts recipe.name
