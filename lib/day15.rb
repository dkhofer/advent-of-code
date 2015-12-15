def find_optimal_cookie(lines, restrict_calories = false)
  ingredients = parse_ingredients(lines)
  find_best_mix(ingredients, restrict_calories)
end

def parse_ingredients(lines)
  lines.map do |line|
    name = line.split(":").first
    parts = line.split(": ").last.split(", ").map { |part| part.split.last.to_i }
    {
      name: name,
      capacity: parts[0],
      durability: parts[1],
      flavor: parts[2],
      texture: parts[3],
      calories: parts[4],
    }
  end
end

def find_best_mix(ingredients, restrict_calories, ingredients_with_amounts = [], teaspoons_remaining = 100)
  if ingredients.empty?
    evaluate_ingredients(ingredients_with_amounts, restrict_calories)
  else
    (0..teaspoons_remaining).map do |i|
      new_ingredients_with_amounts = ingredients_with_amounts + [ingredients.first.merge({ teaspoons: i })]
      find_best_mix(ingredients[1..-1], restrict_calories, new_ingredients_with_amounts, teaspoons_remaining - i)
    end.max
  end
end

def evaluate_ingredients(ingredients, restrict_calories)
  if restrict_calories
    calorie_count = ingredients.reduce(0) { |sum, ingredient| sum + (ingredient[:calories] * ingredient[:teaspoons]) }
    return 0 unless calorie_count == 500
  end

  attribute_totals = [:capacity, :durability, :flavor, :texture].map do |attribute|
    attribute_counts = ingredients.map { |ingredient| ingredient[attribute] * ingredient[:teaspoons] }
    [attribute_counts.reduce(&:+), 0].max
  end
  attribute_totals.reduce(&:*)
end
