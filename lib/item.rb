class Item
  attr_reader :id
  attr_accessor :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def matches?(filter)
    self.name.downcase.include?(filter.downcase)
  end
end