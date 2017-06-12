require_relative './order_hierarchy'

class Order

  include OrderHierarchy

  attr_reader :children

  alias_method :add_product_line, :add_child

  def to_s
    return '' if @children.nil?
    lines = @children.map { |line| line.to_s }
    lines << total_summary unless @children.empty?
    lines.join("\n")
  end

  def total_summary
    "TOTAL $" + sprintf("%.2f", total_price)
  end
end