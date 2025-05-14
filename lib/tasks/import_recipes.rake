require 'json'
require 'zlib'

namespace :import do
  desc "Import recipes from a JSON file"
  task recipes: :environment do
    file_path = 'recipes-en.json.gz'

    unless File.exist?(file_path)
      puts "Error: #{file_path} not found."
      puts "Download file using: wget https://pennylane-interviewing-assets-20220328.s3.eu-west-1.amazonaws.com/recipes-en.json.gz"
      exit(1)
    end

    puts "Starting recipe import from #{file_path}..."

    Zlib::GzipReader.open(file_path) do |file|
      recipes_data = JSON.parse(file.read)
      recipes_data.each do |recipe_data|
        title = recipe_data['title']
        ratings = recipe_data['ratings']
        image = recipe_data['image']
        cuisine = recipe_data['cuisine']
        category = recipe_data['category']
        prep_time = recipe_data['prep_time']
        cook_time = recipe_data['cook_time']
        ingredients_list = recipe_data['ingredients']
        author = recipe_data['author']

        ingredients_text = ingredients_list.join(', ') if ingredients_list.is_a?(Array)

        Recipe.create!(
          title: title,
          image: image,
          ingredients: ingredients_text,
          author: author,
          ratings: ratings,
          cuisine: cuisine,
          category: category,
          prep_time: prep_time,
          cook_time: cook_time
        )
        puts "Recipe: #{title} imported"
      end
    end

    puts "Import finished."
  rescue JSON::ParserError => e
    puts "Error parsing JSON: #{e.message}"
  rescue ActiveRecord::RecordInvalid => e
    puts "Error saving recipe: #{e.message}"
  rescue => e
    puts "An unexpected error occurred: #{e.message}"
  end
end