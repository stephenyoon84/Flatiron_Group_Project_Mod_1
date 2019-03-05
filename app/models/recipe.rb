class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  def print_needed_ingredients
    puts "Recipe for #{self.name}"
    self.ingredients.each { |ingredient| puts "\s- #{ingredient.name}: #{RecipeIngredient.find_by(recipe_id: self.id, ingredient_id: ingredient.id).amount} cl" }
    puts "\s- Preparation: #{self.preparation}"
  end

  def get_ingredients_total_amount
    self.recipe_ingredients.inject(0){|sum, i| sum + i.amount}
  end

  def get_ingredients_total_alcohol
    self.ingredients.inject(0) do |sum, i|
      sum + (i.abv * RecipeIngredient.find_by(recipe_id: self.id, ingredient_id: i.id).amount)
    end
  end

  def calculate_abv
    self.get_ingredients_total_alcohol / self.get_ingredients_total_amount
  end

end
