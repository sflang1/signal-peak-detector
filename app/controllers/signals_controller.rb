class SignalsController < ApplicationController
  def detect_peak
    input_object = ::Inputs::DetectPeakInput.new(data: params[:data], threshold: params[:threshold])

    raise BadRequest.new(input_object.errors.full_messages) unless input_object.valid?
    output = CalculateZScoreService.run(input_object.data).map{ |el| el > params[:threshold].to_f ? 1 : 0 }
    render_success(output)
  end
end