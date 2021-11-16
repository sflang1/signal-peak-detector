module Inputs
  class DetectPeakInput
    include   ActiveModel::Validations
    attr_accessor      :data, :threshold

    validates :threshold,             presence: { message: 'is a required field' }, numericality: { message: 'should be a numeric value' }
    validates :data,                  presence: { message: 'is a required field' }
    validate  :all_input_elements_are_numeric?

    def initialize(args = {})
      args.each do |key, value|
        self.send("#{key}=", value) if self.respond_to? "#{key}="
      end
    end

    private
    def all_input_elements_are_numeric?
      unless self.data.blank?
        self.errors.add(:data, 'elements should be numeric') unless self.data.all? { |el| el.is_a?(Numeric) || el.match?(/^-?\d+(\.\d+)?$/) }
      end
    end
  end
end