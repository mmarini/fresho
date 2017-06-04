require 'bigdecimal'

class ProductLine

  attr_reader :amount, :product, :bundle_lines

  def initialize(amount, product)
    @amount = amount
    @product = product
    @bundle_lines = []
  end

  def fill!
    total_left, bundle_lines = BundleLine.fill(amount, product.bundles)
    @bundle_lines.concat(bundle_lines) if total_left == 0
  end

  def filled?
    @bundle_lines.any?
  end

  def total_summary
    "#{amount} #{product.code} $" + sprintf("%.2f", total_price)
  end

  def total_price
    return BigDecimal.new('0') if @bundle_lines.empty?
    return BigDecimal.new(@bundle_lines[0].total) if @bundle_lines.size == 1
    @bundle_lines.inject { |sum, line| sum + line }
  end

  def to_s
    buffer = [ total_summary ]
    buffer.concat(@bundle_lines.map { |line| line.to_s })
    buffer.join("\n")
  end

end