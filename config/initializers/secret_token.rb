# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
if Rails.env == "development" || Rails.env == "test"
  Ryohiseisan::Application.config.secret_key_base = "d98e5b878d3a762ce032ddc71006f3224131045330174f6e90a420080481abc1c30b1f73c3a89ccdcb79b073281ae0a9319cff812186a72bdfb5d859ed0d6a28"
else
  Ryohiseisan::Application.config.secret_key_base = ENV['SECRET_KEY_BASE']
end
