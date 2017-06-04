require 'bigdecimal'

class BundleLine

  attr_reader :amount, :bundle

  def initialize(amount, bundle)
    @amount = amount
    @bundle = bundle
  end

  def self.fill(amount, bundles)

    # Nothing to do if there are no more bundles
    return [amount, []] if bundles.nil? || bundles.empty?

    # The bundles must be sorted in descending order. This ensures that we try to resolve
    # the biggest bundles first
    sorted_bundles = Bundle.sort_by_size(bundles)

    # It's going to be heavily recursive. Process the head, and pass through the tail
    # to subsequent calls
    head, *tail = sorted_bundles

    # Max number of a bundle we can fill, amount left to fill
    max_number_of_bundle = amount / head.size
    product_to_fill = amount % head.size

    order_lines = []

    if product_to_fill > 0
      if max_number_of_bundle > 0
        # Whilst we can fill the order with the max_number_of_bundle, it might not be the best bundle
        # Count down from the max down to 0
        max_number_of_bundle.downto(0).each do |number_of_bundle|
          # Attempt to fill the order for the remainder
          amount_left, filled_order_line = BundleLine.fill(amount - (number_of_bundle * head.size), tail)
          # If we get a 0, then we've fulfilled the order
          if amount_left == 0
            # Add the order line for the one for the loop
            order_lines << BundleLine.new(number_of_bundle, head) if number_of_bundle > 0
            # Add the order lines returned from the recursive call
            return [0, order_lines.concat(filled_order_line)]
          end
        end
      else
        # max_number_of_bundles is 0, so try and fulfill with the tail
        amount_left, filled_order_line = BundleLine.fill(product_to_fill, tail)
        # If we get a 0, then we've fulfilled the order
        return [0, order_lines.concat(filled_order_line)] if amount_left == 0
      end
    else
      # Product to fill is 0, so this is what we want
      order_lines << BundleLine.new(max_number_of_bundle, head)
    end

    [product_to_fill, order_lines]
  end

  def to_s
    "#{amount} x #{bundle.size} $" + sprintf("%.2f", total)
  end

  def total
    return BigDecimal('0') if bundle.nil?
    BigDecimal.new((amount * bundle.price).to_s)
  end

  def +(other)
    total + other
  end

  def coerce(other)
    return self, other
  end
end