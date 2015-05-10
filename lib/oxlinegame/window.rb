require "onsengame/window"
require "oxlinegame/scene"

module Oxlinegame
  class Window < Onsengame::Window
    def initialize(options={})
      super
      @options[:n_rows] ||= 3
      if @options[:n_rows] < 5
        default_n_win_cells = @options[:n_rows]
      else
        default_n_win_cells = 5
      end
      @options[:n_win_cells] ||= default_n_win_cells
      @options[:n_players] ||= 2
      self.caption = "Oxline"
      @scenes = []
      @scenes << Scene::Title.new(self)
    end
  end
end
