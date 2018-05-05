class NotifyUsersJob < ApplicationJob
  queue_as :default

  def perform model, price
    NotifyUsers.call model, price
  end
end
