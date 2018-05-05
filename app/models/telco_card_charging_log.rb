class TelcoCardChargingLog < ApplicationRecord
end

# == Schema Information
#
# Table name: telco_card_charging_logs
#
#  id             :integer          not null, primary key
#  provider       :string
#  code           :integer
#  msg            :string
#  info_card      :integer
#  transaction_id :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
