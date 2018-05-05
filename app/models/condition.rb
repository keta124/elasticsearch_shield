class Condition < ApplicationRecord
  belongs_to :user

  enum source: {
    coinbase: 0,
    gdax: 1,
    bittrex: 2,
    hitbtc: 3,
    poloniex: 4,
    cryptopia: 5
  }

  enum currency: {
    btc: 'BTC',
    usd: 'USD',
    usdt: 'USDT',
    vnd: 'VND',
  }

  enum operation: {
    less_than_or_equal: 0,
    greater_than_or_equal: 1,
  }

  validates :operation, :currency, :source, :coin, :value, presence: true

end

# == Schema Information
#
# Table name: conditions
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  last_notified_at :datetime
#  source           :integer          default("0"), not null
#  coin             :string
#  currency         :string
#  value            :decimal(20, 10)
#  operation        :integer
#  active           :boolean          default("true")
#
# Indexes
#
#  index_conditions_on_source   (source)
#  index_conditions_on_user_id  (user_id)
#
