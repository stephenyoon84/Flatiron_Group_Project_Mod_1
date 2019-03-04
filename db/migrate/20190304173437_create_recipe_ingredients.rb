class CreateRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ingredients do |r|
      r.integer :recipe_id
      r.integer :ingredient_id
      r.float :amount
    end
  end
end
