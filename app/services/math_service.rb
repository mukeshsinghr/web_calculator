
# Service to perform all mathematical calculations.
class MathService

  attr_accessor :logger
  
  def initialize
    @logger = Rails.logger
  end

  # Method to perfrom all expression evaluation using eval function.
  def eval_expression(expression)
    if expression.count("a-zA-Z") > 0
      result = "Incorrect expression or Number"
    else
      expression = expression.gsub('/', '*1.0/')  if expression.include?("/")
      result = eval(expression).round(2)
    end
    result
  end

  # Method to perfrom all expression evaluation without eval function.
  def calculate_expressions(expr)
    res = 0
    if expr.count("a-zA-Z") > 0
      res = "Incorrect expression or Number"
    else
      while(has_operators?(expr))
        @logger.info "Expression=#{expr}"
        part_expr = ""
        operator = next_operator(expr)
        @logger.info "Operator=#{operator}"
        idx = expr.index(operator)
        val1 = find_prv_operand(expr, idx)
        val2 = find_next_operand(expr, idx)
        res = perform_calc(operator, val1, val2)
        part_expr = "#{val1}#{operator}#{val2}"
        @logger.info "#{part_expr}=#{res}"
        expr.gsub!(part_expr, res.to_s)
      end
      res = res.round(2)
    end
    res
  end

  #Method to check if expression has operators
  def has_operators?(str)
    true if /[*\-\+\/]/ =~ str
  end

  # Perform binary opration on operands
  def perform_calc(opr, val1, val2)
    result = 0
    case opr
    when '*'
      result = val1.to_f * val2.to_f
    when "/"
      result = val1.to_f / val2.to_f
    when "+"
      result = val1.to_f + val2.to_f
    when "-"
      result = val1.to_f - val2.to_f
    end
    result.round(2)
  end

  # Method returns the operator based on precendence.
  def next_operator(expr)
    return '*' if expr.index('*')
    return '/' if expr.index('/')
    return '+' if expr.index('+')
    return '-' if expr.index('-')
  end

  # Method to return first operands in the expression based on index of operator
  def find_prv_operand(expr, idx)
    result = ""
    while(idx > 0)
      prv_char = expr[idx-1]
      if has_operators?(prv_char)
        break
      else
        result = prv_char + result
      end
      idx-=1
    end
    @logger.info "Previous no=#{result}"
    result
  end

  def find_next_operand(expr, idx)
    result = ""
    while(idx < expr.length)
      next_char = expr[idx+1]
      if next_char.nil? || has_operators?(next_char)
        break
      else
        result = result + next_char
      end
      idx+=1
    end
    @logger.info "Next no=#{result}"
    result
  end

  #For direct testing purpose
  # MathService.new

end
