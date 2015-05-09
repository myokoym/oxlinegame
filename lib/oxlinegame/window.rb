require "onsengame/window"
require "oxlinegame/scene"

module Oxlinegame
  class Window < Onsengame::Window
    def initialize(options={})
      super
      self.caption = "Oxline"
      @scenes = []
      @scenes << Scene::Title.new(self)
    end
  end
end
