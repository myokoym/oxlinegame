require "onsengame/window"
require "oooxxx/scene"

module Oooxxx
  class Window < Onsengame::Window
    def initialize(options={})
      super
      self.caption = "Oooxxx"
      @scenes = []
      @scenes << Scene::Title.new(self)
    end
  end
end
