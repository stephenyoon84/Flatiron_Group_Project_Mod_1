class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |r|
      r.string :name
      r.integer :abv
      r.string :preparation
    end
  end
end
