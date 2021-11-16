class SignalsController < ApplicationController
  def detect_peak
    input_object = ::Inputs::DetectPeakInput.new(data: params[:data], threshold: params[:threshold])

    #byebug
    raise BadRequest.new(input_object.errors.full_messages) unless input_object.valid?
    output = input_object.data.map { |input_element| input_element > input_object.threshold ? 1 : 0 }
    render_success(output)
  end
end