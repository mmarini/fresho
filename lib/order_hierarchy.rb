module OrderHierarchy

  def initialize_children
    @children ||= []
  end

  def add_child(child)
    return if child.nil?
    initialize_children
    @children << child
  end

  def concat_children(children)
    return if children.nil?
    initialize_children
    @children.concat(children)
  end

  # Order hierarchy introduced due to repetition in the total_price method across order and product_line
  # The following methods need to be implemented on the class that will be used as the child:
  # '+' and 'coerce'
  # The following method needs to be implemented on the last child:
  # total_price
  def total_price
    return BigDecimal.new('0') if @children.nil? || @children.empty?
    return BigDecimal.new(@children[0].total_price) if @children.size == 1
    @children.inject { |sum, line| sum + line }
  end

end