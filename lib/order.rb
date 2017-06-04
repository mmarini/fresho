class Order

  attr_reader :amount, :product, :order_lines

  def initialize(amount, product)
    @amount = amount
    @product = product
    @order_lines = []
  end

  def fill(bundles)

    total_left, order_lines = OrderLine.fill(amount, bundles)

    @order_lines.concat(order_lines) if total_left == 0
  end

end