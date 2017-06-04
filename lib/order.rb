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
    total_line = ""
    @product_lines.each do |line|
      total_line += line.to_s + "\n"
    end
    total_line
  end

end