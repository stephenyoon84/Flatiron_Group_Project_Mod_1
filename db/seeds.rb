require_relative '../config/environment'
require 'json'
require 'sqlite3'

# class ImportJson
  ingredient_path = File.expand_path('../ingredients.json', __FILE__)
  # ingredient_file = File.read(path)
  ingredient_hash = JSON.parse(File.read(ingredient_path))

  ingredient_hash.each do |k, v|
    Ingredient.find_or_create_by(name: k, abv: v["abv"], taste: v["taste"])
  end

  recipe_path = File.expand_path('../recipes.json', __FILE__)
  recipe_array = JSON.parse(File.read(recipe_path))

  recipe_array.each do |x|
    Recipe.find_or_create_by(name: x["name"])
  end

  recipe_array.each do |x|
    x["ingredients"].each do |y|
      if Ingredient.find_by(name: y["ingredient"])
        RecipeIngredient.find_or_create_by(recipe_id: Recipe.find_by(name: x["name"]).id,
        ingredient_id: Ingredient.find_by(name: y["ingredient"]).id,
        amount: y["amount"])
      end
    end
  end
  # DB = SQLite3::Database.new "cocktail.db"
  #
  # def self.insert_ingredient_to_table
  #   @ingredient_hash.each do |k, v|
  #     sql = <<-SQL
  #         INSERT INTO ingredients (name, abv, taste) VALUES (?, ?, ?)
  #         SQL
  #     DB.execute(sql, k, v["abv"], v["taste"])
  #   end
  # end
  #
  # def self.insert_recipe_to_table
  #   @recipe_array.each do |x|
  #     sql = <<-SQL
  #         INSERT INTO recipes (name) VALUES (?)
  #         SQL
  #     DB.execute(sql, x["name"])
  #   end
  # end
  #
  # def self.insert_recipe_ingredient_to_table
  #
  # end
# end

# ImportJson.insert_ingredient_to_table
# ImportJson.insert_recipe_to_table
# ImportJson.insert_recipe_ingredient_to_table


# Ingredient.create(data)
