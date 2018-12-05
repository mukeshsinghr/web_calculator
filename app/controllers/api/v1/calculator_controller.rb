class Api::V1::CalculatorController < ApplicationController

	# Perform the expression evaluation and return result in response of json.
	def perform_calculation
		result = MathService.eval_expression(input_expression)
		render json: {result: result}
	end

	# Render the home page.
	def index

	end


	private
		# Strong parameters for required attributes.
		def input_expression
			params.require(:expression)
		end

end
