class Order

  attr_reader :product_lines

  def initialize
    @product_lines = []
  end

  def add_product_line(product_line)
    return if product_line.nil?
    @product_lines << product_line
  end

  def to_s
    lines = @product_lines.map { |line| line.to_s }
    lines.join("\n")
  end

end