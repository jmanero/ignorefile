require 'pathname'

##
# Ignore things
##
class IgnoreFile
  attr_reader :statements
  COMMENT_OR_WHITESPACE = /^\s*(?:#.*)?$/.freeze

  def initialize(*args)
    @statements = []

    args.each do |arg|
      case
      when arg.is_a?(Array) then push(arg)
      when File.exist?(arg) then load_file(arg)
      else push(arg)
      end
    end
  end

  def push(*arg)
    statements.push(*arg.flatten.map(&:strip))

    self
  end
  alias_method :<<, :push

  def load_file(file)
    file = Pathname.new(file)
    return unless file.exist?

    push(file.readlines.map(&:strip).reject do |line|
      line.empty? || line =~ COMMENT_OR_WHITESPACE
    end)

    self
  end

  def ignored?(file)
    return true if file.to_s.strip.empty?

    file = Pathname.new(file)
    statements.any? { |statement| file.fnmatch?(statement) }
  end

  def apply(files)
    files.flatten.reject { |file| ignored?(file) }
  end

  def apply!(files)
    files.flatten.reject! { |file| ignored?(file) }
  end
end
