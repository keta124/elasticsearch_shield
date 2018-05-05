class SmsLog < ApplicationRecord
end

# == Schema Information
#
# Table name: sms_logs
#
#  id         :integer          not null, primary key
#  provider   :string
#  status     :string
#  to_number  :string
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_sms_logs_on_user_id  (user_id)
#
