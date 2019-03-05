class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  def print_needed_ingredients
    self.ingredients.each { |ingredient| puts "#{ingredient.name}" }
  end
  
end
