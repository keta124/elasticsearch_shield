class SendSmsWorker
  include Sidekiq::Worker

  def perform user_id, phone, content
    SpeedsmsApi.send user_id, phone, content
  end
end
