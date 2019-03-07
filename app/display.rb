require_relative '../config/environment'
require 'tty-table'
require_relative './models/recipe'
require_relative './models/ingredient'

class DisplayTable
  def self.recipes_table
    rows = []
    i = 0
    while i < 11
      rows << (1..7).collect{|y| "#{y+(7*i)}. #{Recipe.find(y + (7 * i)).name}"}
      i += 1
    end
    table = TTY::Table.new(rows)
    new_table = table.render(:ascii, resize: true) do |renderer|
        renderer.border.separator = :each_row
      end
    puts new_table
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

module Screen
   def self.clear
       print "\ec\e[3J"
   end

   def self.next
     user_input = nil
     while user_input == nil
       user_input = gets.chomp
     end
   end
end
