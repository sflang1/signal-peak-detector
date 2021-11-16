class CalculateZScoreService

  def self.find_average_standard_deviation(items)
    average = items.sum / items.count
    average_squared = items.sum { |el| el**2 } / items.count
    standard_deviation = (average_squared - average**2) ** 0.5

    return average, standard_deviation
  end

  def self.run(inputs)
    inputs = inputs.map(&:to_f)

    inputs.each_with_index.inject([]) do |acc, (_, index)|
      moving_inputs = inputs[0..index]
      average, standard_deviation = find_average_standard_deviation(moving_inputs)

      z_score = standard_deviation == 0 ? 0 : (moving_inputs.last - average) / standard_deviation
      acc.push(z_score)
      acc
    end
  end
end