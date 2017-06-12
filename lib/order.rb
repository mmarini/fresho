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
    lines << total_summary unless @product_lines.empty?
    lines.join("\n")
  end

  def total_price
    return BigDecimal.new('0') if @product_lines.empty?
    return BigDecimal.new(@product_lines[0].total_price) if @product_lines.size == 1
    @product_lines.inject { |sum, line| sum + line }
  end

  def total_summary
    "TOTAL $" + sprintf("%.2f", total_price)
  end
end