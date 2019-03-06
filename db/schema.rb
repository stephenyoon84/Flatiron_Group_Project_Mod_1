# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_06_175844) do

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "abv"
    t.string "taste"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "ingredient_id"
    t.float "amount"
  end

  create_table "recipe_specials", force: :cascade do |t|
    t.integer "recipe_id"
    t.string "special"
    t.string "garnish"
    t.index ["recipe_id"], name: "index_recipe_specials_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.integer "abv"
    t.string "preparation"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "user_name"
    t.string "password_digest"
  end

end
