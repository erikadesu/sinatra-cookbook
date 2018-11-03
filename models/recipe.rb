class Recipe
  attr_reader :name, :description, :ingredients, :instructions, :done
  def initialize(name, description, ingredients, instructions, done = false)
    @name = name
    @description = description
    @ingredients = ingredients
    @instructions = instructions
    @done = done
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
