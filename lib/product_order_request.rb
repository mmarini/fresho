class ProductOrderRequest

  attr_reader :amount, :product_code

  def initialize(order_request)
    @amount, @product_code = order_request.split
  end

  def amount
    @amount.to_i
  end

  def is_valid?
    !(@amount.nil? || !/\A\d+\z/.match(@amount) || @product_code.nil?)
  end

end