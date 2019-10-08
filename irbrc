require "irb"
require "irb/completion"

if defined?(Bundler)
  Gem.path.each do |gemset|
    $LOAD_PATH.concat Dir.glob("#{gemset}/gems/pry-*/lib")
  end
  $LOAD_PATH.uniq!
end

begin
  require "pry-editline"
rescue LoadError
  # no-op
end

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] =
  if defined?(Rails) && Rails.root
    Rails.root.join("tmp", "history.rb")
  else
    File.expand_path("~/.history.rb")
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
