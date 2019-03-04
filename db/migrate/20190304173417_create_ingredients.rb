class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |i|
      i.string :name
      i.integer :abv
      i.string :taste
    end
  end
end
