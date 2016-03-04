Griddler.configure do |config|
  config.processor_class = EmailProcessor # MyEmailProcessor
  config.reply_delimiter = '-- REPLY ABOVE THIS LINE --'
  config.email_service = :mailgun # :cloudmailin, :postmark, :mandrill, :mailgun
end
