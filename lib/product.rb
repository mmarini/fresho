class Product

  attr_reader :name, :bundles

  def initialize(name, bundles = {})
    @name = name
    @bundles = bundles
  end

end