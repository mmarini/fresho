class Shop

  attr_reader :products

  def initialize(products = [])
    @products = {}
    products.each { |product| @products[product.code] = product }
  end

  def process_order(order_lines)
    order = Order.new
    order_lines.each do |order_line|
      amount, product_code = order_line.split
      product = @products[product_code]
      unless product.nil?
        product_line = ProductLine.new(amount.to_i, product)
        product_line.fill!
        order.add_product_line(product_line) if product_line.filled?
      end
    end
    order
  end

end