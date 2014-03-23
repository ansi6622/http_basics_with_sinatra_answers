require './lib/item'

class ItemsRepository
  def initialize
    @items = [Item.new(1, "Channa Masala"), Item.new(2, "Chicken Tikka Masala"), Item.new(3, "Saag Paneer")]
  end

  def items(filter)
    if filter.nil?
      @items
    else
      matched_items = []
      @items.each do |item|
        if matches?(filter, item)
          matched_items << item
        end
      end
      matched_items
    end
  end

  def find(id)
    @items.each do |item|
      if item.id == id
        return item
      end
    end
    nil
  end

  def add(name)
    next_id = @items.length + 1
    @items << Item.new(next_id, name)
  end

  def update(id, name)
    item = find(id)
    item.name = name
  end

  def delete(id)
    @items.delete(find(id))
  end

  private
  def matches?(filter, item)
    puts item.name.downcase.include?(filter.downcase)
    item.name.downcase.include?(filter.downcase)
  end
end