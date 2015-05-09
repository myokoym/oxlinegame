module Oxlinegame
  module ZOrder
    [
      :BACK,
      :OBJECT,
      :TEXT,
    ].each_with_index do |type, i|
      const_set(type, i)
    end
  end
end
