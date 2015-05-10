require "onsengame/window"
require "oxlinegame/scene"

module Oxlinegame
  class Window < Onsengame::Window
    def initialize(options={})
      super
      @options[:n_rows] ||= 3
      @options[:n_win_cells] ||= 3
      @options[:n_players] ||= 2
      self.caption = "Oxline"
      @scenes = []
      @scenes << Scene::Title.new(self)
    end
  end
end
