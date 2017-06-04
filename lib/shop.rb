class Shop

  attr_reader :products

  def initialize(products = [])
    @products = {}
    products.each { |product| @products[product.code] = product }
  end

end