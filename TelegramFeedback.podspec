Pod::Spec.new do |s|

  s.name         = "TelegramFeedback"
  s.version      = "1.0"
  s.summary      = "Simple framework for adding Telegram feedback in an iOS App"
  s.description  = "The framework contains helper class for sending messages in Telegram's channel"
  s.homepage     = "https://github.com/NoFearJoe/TelegramFeedback"

  s.license      = { :type => "MIT", :file => "LICENSE.txt"}

  s.author       = { "Ilya Kharabet" => "ilyakharabet@gmail.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/NoFearJoe/TelegramFeedback.git", :tag => s.version }

  s.source_files = "TelegramFeedback/TelegramFeedback/Sources/**/*.swift"

end
