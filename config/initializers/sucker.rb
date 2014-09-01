Sucker.configure do |config|
  config.key              = ENV["AWS_ACCESS_KEY"]
  config.secret           = ENV["AWS_SECRET_KEY"]
  config.associate_tag    = ENV["AWS_ASSOCIATE_TAG"]
  config.locale           = "us"
end
