Rails.application.config.middleware.use OmniAuth::Builder do
 provider :github, ENV['c327a0bba477e2b2ea6f'], ENV['a2ef6bac56f8679326c0316a6b4f1fc686bbf2eb']
end