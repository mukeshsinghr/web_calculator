
# Service to perform all mathematical calculations.
class MathService

	# Method to perfrom all expression evaluation.
	def self.eval_expression(expression)
		if expression.count("a-zA-Z") > 0
			result = "Incorrect expression or Number"
		else
			expression = expression.gsub('/', '*1.0/')  if expression.include?("/")
			result = eval(expression).round(2)
		end
		result
	end

end
