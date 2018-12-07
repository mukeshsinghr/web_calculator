class Api::V1::CalculatorController < ApplicationController

  # Perform the expression evaluation and return result in response of json.
  def perform_calculation
    result1 = math.calculate_expressions(input_expression)
    result2 = math.eval_expression(input_expression)
    Rails.logger.info "=================================================="
    Rails.logger.info "Result using Ruby.eval=#{result2}"
    Rails.logger.info "Result using my OWN implementation=#{result2}"
    Rails.logger.info "=================================================="
    # render json: {result: "#{result1} == #{result2}"}
    render json: {result: result1}
  end

  # Render the home page.
  def index

  end


  private
    # Strong parameters for required attributes.
    def input_expression
      params.require(:expression)
    end

    def math
      MathService.new
    end


end
