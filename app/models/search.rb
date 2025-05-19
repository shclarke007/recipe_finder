class Search
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :ingredients, :string
  attribute :category, :string

  def run_search
    recipes = Recipe.all

    if ingredients.present?
      recipes = recipes.search_by_ingredients(ingredients)
    end

    if category.present?
      recipes = recipes.where("category ILIKE ?", "%#{category}%")
    end
    recipes
  end
end
