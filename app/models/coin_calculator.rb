class CoinCalculator < ApplicationRecord
end

# == Schema Information
#
# Table name: coin_calculators
#
#  id             :integer          not null, primary key
#  coin           :string           not null
#  difficulty     :decimal(30, 10)  not null
#  block_reward   :decimal(20, 10)  not null
#  type_algorithm :integer          default("0")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
