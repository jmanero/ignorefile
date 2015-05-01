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
    statements.sort!
    statements.uniq!
  end
  alias_method :<<, :push

  def load_file(ifile)
    push(File.readlines(ifile).map(&:strip).reject do |line|
      line.empty? || line =~ COMMENT_OR_WHITESPACE
    end)
  end

  def ignored?(file)
    statements.any? { |statement| File.fnmatch?(statement, file) }
  end

  def apply(*files)
    files.flatten.reject do |file|
      file.strip.empty? || ignored?(file)
    end
  end

  def apply!(files)
    files.reject! do |file|
      file.strip.empty? || ignored?(file)
    end
  end
end
