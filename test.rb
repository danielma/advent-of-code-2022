# frozen_string_literal: true

opts =
  ARGV.each_with_object({}) do |opt, obj|
    key, value = opt.split("=", 2)

    obj[key] = value || true
  end

if ENV["test_filter"] && !opts.key?("--filter")
  opts["--filter"] = ENV["test_filter"]
end

ARGV.clear

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end

IO.popen(%w[swift test]) do |io|
  io.each_line do |line|
    next if opts["--filter"] && !line.include?(opts["--filter"])

    puts line.gsub("failed", "failed".red).gsub("passed", "passed".green)
  end
end
