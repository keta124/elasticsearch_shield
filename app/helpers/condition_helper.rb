module ConditionHelper

  def format_condition_value condition
    operation = condition.greater_than_or_equal? ? '≥' : '≤'

    symbol =
      case condition.currency.upcase
      when 'VND'
        'VND'
      when 'USD'
        'U$'
      when 'BTC'
        'BTC'
      end

    value = number_with_delimiter(condition.value)
    "#{operation} #{symbol} #{value}"
  end

end
