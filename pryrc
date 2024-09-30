load File.expand_path("~/.irbrc")

Pry.config.auto_indent = false
Pry.config.color = false
Pry.config.history_file =
  if defined?(Rails) && Rails.respond_to?(:root)
    Rails.root.join("tmp", "history-#{Rails.env}.rb")
  else
    File.expand_path("~/.history.rb")
  end
