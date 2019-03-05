class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  def print_needed_ingredients
    self.ingredients.each { |ingredient| puts "#{ingredient.name}" }
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
