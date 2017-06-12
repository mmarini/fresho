class ProductOrderRequest

  attr_reader :amount, :product_name

  def initialize(order_request)
    @amount, @product_name = order_request.split
  end

  def amount
    @amount.to_i
  end

  def is_valid?
    !(@amount.nil? || !/\A\d+\z/.match(@amount) || @product_name.nil?)
  end

end