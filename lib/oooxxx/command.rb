require "thor"
require "oooxxx"

module Oooxxx
  class Command < Thor
    desc "version", "Show version"
    def version
      puts(VERSION)
    end

    desc "start [OPTIONS]", "Run game"
    option :fullscreen, type: :boolean
    def start
      @window = Window.new(options.dup)
      @window.show
    end
  end
end
