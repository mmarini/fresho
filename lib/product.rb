class Product

  attr_reader :code, :name, :bundles

  def initialize(code, name, bundles = {})
    @code = code
    @name = name
    @bundles = bundles
  end

end