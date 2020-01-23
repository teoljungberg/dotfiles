load File.expand_path("~/.irbrc")

Pry.config.history.file =
  if defined?(Rails)
    Rails.root.join("tmp", "history-#{Rails.env}.rb")
  else
    File.expand_path("~/.history.rb")
  end
