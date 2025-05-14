class Recipe < ApplicationRecord
  def self.search_by_ingredients(ingredient_list)
    return none if ingredient_list.blank?

    ingredients = ingredient_list.split(',').map(&:strip).reject(&:blank?)
    return none if ingredients.empty?

    query = where('') 
    ingredients.each do |ingredient|
      query = query.where("ingredients ILIKE ?", "%#{ingredient}%")
    end

    query
  end
end
