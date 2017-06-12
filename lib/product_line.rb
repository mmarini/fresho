require 'bigdecimal'
require_relative './order_hierarchy'

class ProductLine

  include OrderHierarchy

  attr_reader :amount, :product, :children

  def initialize(amount, product)
    @amount = amount
    @product = product
  end

  def fill!
    total_left, bundle_lines = BundleLine.fill(amount, product.bundles)
    concat_children(bundle_lines) if total_left == 0
  end

  def filled?
    !@children.nil? && @children.any?
  end

  def total_summary
    "#{amount} #{product.name} $" + sprintf("%.2f", total_price)
  end

  def to_s
    buffer = [ total_summary ]
    buffer.concat(@children.map { |line| line.to_s })
    buffer.join("\n")
  end

  def +(other)
    total_price + other
  end

  def coerce(other)
    return self, other
  end
end