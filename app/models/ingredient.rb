class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients


  def print_possible_cocktails
    self.recipes.each { |drink| puts "#{drink.name}" }
  end

  def possible_cocktails_two_ing(ing2)
    (self.recipes & ing2.recipes).each{|d| puts d.name}
  end

end
