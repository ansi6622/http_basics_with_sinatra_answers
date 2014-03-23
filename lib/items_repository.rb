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
        # you found the item so just return it.
        return item
      end
    end
    # you didn't find the item so signal that you didn't find it
    nil
  end

  def add(name)
    # ids need to be unique
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
    item.name.downcase.include?(filter.downcase)
  end
end