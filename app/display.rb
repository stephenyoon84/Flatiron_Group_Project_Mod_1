require_relative '../config/environment'
require 'tty-table'
require_relative './models/recipe'
require_relative './models/ingredient'

class DisplayTable
  def self.recipes_table
    # rows = [[], [], [], [], [], [], [], [], [], [], []]
    rows = []
    i = 0
    # rows.each do |x|
      # binding.pry
    while i < 11
      # rows << :separator
      rows << (1..7).collect{|y| "#{y+(7*i)}. #{Recipe.find(y + (7 * i)).name}"}
      # binding.pry
      i += 1
    end
    # end
    table = TTY::Table.new(rows)
    new_table = table.render(:ascii, resize: true) do |renderer|
        renderer.border.separator = :each_row
      end
    puts new_table
    # puts rows
  end

  def self.ingredients_table
    rows = [[], [], [], []]
    i = 0
    while i < 4
      (1..13).each{|y| rows[i] << "#{y+(13*i)}. #{Ingredient.find(y + (13 * i)).name}"}
      rows
      i += 1
    end
    table = TTY::Table.new(rows)
    new_table = table.render(:ascii, resize: true, multiline: true) do |renderer|
      renderer.border.separator = :each_row
    end
    puts new_table
  end
end

# DisplayTable.recipes_table
# DisplayTable.ingredients_table