require "thor"
require "oxlinegame"

module Oxlinegame
  class Command < Thor
    desc "version", "Show version"
    def version
      puts(VERSION)
    end

    desc "start [OPTIONS]", "Run game"
    option :fullscreen, type: :boolean
    option :n_rows, type: :numeric
    option :n_win_cells, type: :numeric
    option :n_players, type: :numeric
    def start
      @window = Window.new(options.dup)
      @window.show
    end
  end
end
