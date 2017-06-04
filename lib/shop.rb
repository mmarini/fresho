class Shop

  def initialize(products = [])
    @products = {}
    products.each { |product| @products[product.code] = product }
  end

  def process_order(order_lines)
    order = Order.new

    order_request = Shop.validate_order(order_lines)

    order_request.each do |order_line|
      product = @products[order_line.product_code]
      unless product.nil?
        product_line = ProductLine.new(order_line.amount, product)
        product_line.fill!
        order.add_product_line(product_line) if product_line.filled?
      end
    end
    order
  end

  private

  def self.validate_order(order_lines)
    transformed_lines = order_lines.map { |line| ProductOrderRequest.new(line) }
    transformed_lines.select { |line| line.is_valid? }
  end

end