class CheckConditionWorker
  include Sidekiq::Worker
  sidekiq_options unique: :until_and_while_executing,
                  unique_args: ->(args) { [ args.first ] }

  def perform id
    condition = Condition.find(id)
    if condition.active?
      coin = condition[:coin]
      value = condition[:value]
      source = condition[:source]
      currency = "price_#{condition[:currency]}"
      value_commas = ActiveSupport::NumberHelper.number_to_delimited(value)
      price_last = ExchangeCoin.where(market: source,coin: coin).last[currency]

      case
      when (price_last >= value) && condition.greater_than_or_equal?
        content = "Coin #{coin} dang tang vuot #{value_commas} #{condition.currency}"
      when (price_last <= value) && condition.less_than_or_equal?
        content = "Coin #{coin} dang giam duoi #{value_commas} #{condition.currency}"
      end

      if content
        SendSmsWorker.perform_async(condition.user.id, condition.user.phone, content)
        condition.update active: false
      end
    end
  end
end
