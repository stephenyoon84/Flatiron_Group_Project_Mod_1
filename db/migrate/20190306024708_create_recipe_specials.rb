class CreateRecipeSpecials < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_specials do |r|
      r.belongs_to :recipe
      r.string :special
      r.string :garnish
    end
  end
end
