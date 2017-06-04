class Product

  attr_reader :code, :bundles

  def initialize(code, name, bundles = {})
    @code = code
    @name = name
    @bundles = bundles
  end

end