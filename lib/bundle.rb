class Bundle

  attr_reader :size, :price

  def initialize(size, price)
    @size = size
    @price = price
  end

  def self.sort_by_size(bundles)
    bundles.sort { |x, y| y.size <=> x.size }
  end

end