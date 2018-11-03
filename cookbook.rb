require 'csv'
class Cookbook
  # repository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @cookbook = [] # array of Recipe.new
    CSV.foreach(@csv_file_path) do |row|
      row[4] = true if row[4] == 'done'
      @cookbook << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end

  def add_recipe(recipe)
    @cookbook << recipe
    save_to_csv
  end

  def all
    @cookbook
  end

  def find(index)
    @cookbook[index]
  end

  def remove_recipe(recipe_index)
    @cookbook.delete_at(recipe_index)
    save_to_csv
  end

  def save
    save_to_csv
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @cookbook.each do |recipe|
        done = recipe.done? ? 'done' : 'not done'
        csv << [recipe.name,
                recipe.description,
                recipe.ingredients,
                recipe.instructions,
                done]
      end
    end
  end
end
