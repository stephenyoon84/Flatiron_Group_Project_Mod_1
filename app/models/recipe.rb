class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_specials

  def print_needed_ingredients
    puts "\n\n\s\e[4m#{self.name} Recipe\e[0m"
    self.ingredients.each { |ingredient| puts "\s- #{ingredient.name}: #{RecipeIngredient.find_by(recipe_id: self.id, ingredient_id: ingredient.id).amount} cl" }
    if self.recipe_specials.collect{|x| x.special if x.special}.uniq != [nil]
      self.recipe_specials.collect{|x| x.special if x.special}.uniq.each{|y| puts "\s- Special: #{y}"}
    elsif self.recipe_specials.collect{|x| x.garnish if x.garnish}.uniq != [nil]
      puts "\s- Garnish: #{self.recipe_specials.collect{|x| x.garnish if x.garnish}.uniq[0]}"
    end
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
    (self.get_ingredients_total_alcohol / self.get_ingredients_total_amount).to_i
  end

end
