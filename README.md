# Group Project for Module 1 - Sean Lucius & Stephen Yoon

- Get Your Cocktail App

- Search
  - Search for cocktails that you can make with the ingredients you have on hand.
  - Select a cocktail from a menu and retrieve its ingredients/recipe.
  - Search for a list of cocktails based on strength (light, medium, strong).

  - User
    - Guest: Doesn't have account. Guest can only use search function.
    - User: Has account. User can create their own favorite list of cocktails.
    - Bartender: Possible to check how many cocktails they can make.


- Initial steps to run this app
    1. run `rake db:migrate` and `rake db:seed` in your terminal to create database
    2. input `ruby bin/run.rb` in your terminal to begin using the app

- Story (At least 4)
  1. As a user, I want to be able to enter an ingredient/ingredients that I currently have and get back a list of drinks that I can make with what I have.
  2. As a user, I want to be able to select a drink from a menu and get back all of the required ingredients, amounts, and mixing instructions
  3. As a guest, ~~
  4. As a bartender, ~~
  5. As a user I would like to be able to access a list of drinks according to their strengths (light, medium, strong).

- Table Information
  - Recipes
    - name
    - preparation

  - Ingredients
    - name
    - abv
    - taste(optional)

  - RecipeIngredients
    - recipe_id
    - ingredient_id
    - amount

  - RecipeSpecials
    - special
    - garnish

  - User
    - name
    - password(simple vs real)
  - etc.

- Title
  - http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Get%20your%20Cocktail

- JSON url
  - <a href="https://github.com/teijo/iba-cocktails" target="_blank">IBA-Cocktails</a>
    - <a href="https://github.com/teijo/iba-cocktails/blob/master/ingredients.json" target="_blank">Ingredient</a>
    - <a href="https://github.com/teijo/iba-cocktails/blob/master/recipes.json" target="_blank">Recipe</a>

- Final Project Guideline
  - https://learn.co/tracks/web-development-immersive-2-0-module-one/project-mode/projects/final-project-guidelines

- Github
  - Sean: https://github.com/seanlucius
  - Stephen: https://github.com/stephenyoon84
