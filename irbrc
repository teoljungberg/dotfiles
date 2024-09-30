require "irb"
require "irb/completion"

ENV["TERM"] = "xterm"

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] =
  if defined?(Rails) && Rails.respond_to?(:root)
    Rails.root.join("tmp", "history.rb")
  else
    File.expand_path("~/.history.rb")
  end
IRB.conf[:USE_COLORIZE] = false

if defined?(Rails)
  ActiveSupport::LogSubscriber.colorize_logging = false
end

unless ENV.key?("IRB_RELINE")
  begin
    require "readline"
    IRB.conf[:USE_READLINE] = true
  rescue LoadError
    warn "warning: readline not available"
  end
end

class Object
  def interesting_methods
    case self.class
    when Class
      self.public_methods.sort - Object.public_methods
    when Module
      self.public_methods.sort - Module.public_methods
    else
      self.public_methods.sort - Object.new.public_methods
    end
  end
end

def capture_exception(&block)
  block.call
rescue => exception
  exception
end

def time(&block)
  t0 = Time.now
  block.call
  puts Time.now - t0
end

def ri(*args)
  help(*args)
end
