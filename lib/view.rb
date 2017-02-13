# list method: to put all the recipes, add and remove methods
# (add et remove to get the use inputs)

require_relative 'cookbook'

class View
  def list(cookbook)
    # on loop sur l'array recipes de cookbook
    cookbook.recipes.each_with_index do |recipe, index|
      puts "#{recipe.done} #{index + 1}. #{recipe.name}: #{recipe.description} #{recipe.cooking_time}min"
    end
  end

  def mark_as_done
    puts "Which recipe do you want to mark as done?"
    gets.chomp.to_i
  end

  def add
    hash = {}
    puts "What is the name of the recipe you want to add?"
    puts ">"
    hash[:name] = gets.chomp
    puts "What is the description of this recipe?"
    puts ">"
    hash[:description] = gets.chomp
    puts "What is the cooking time (in min) of this recipe?"
    puts ">"
    hash[:cooking_time] = gets.chomp
    return hash
  end

  def remove
    puts "What is the number of the recipe you want to delete?"
    puts ">"
    gets.chomp.to_i
  end

  def parse
    puts "For which ingredient do you want to import recipes?"
    gets.chomp
  end

  def return_result(array)
    "Those are the results:"
    array.each_with_index {|element, index| puts "#{index + 1}. #{element[:name]}"} # a mettre dans view
  end

  def which_difficulty
    puts "Which level of difficulty do you want to select? \n Easy \n Very Easy \n Moderate \n Difficult \n All"
    gets.chomp.to_s
  end

  def which_number
    puts "Please enter the number of the recipe you want to add"
    gets.chomp.to_i
  end


end
