require 'spec_helper'

describe Order do

  let(:bundle_3) { Bundle.new(3, 5.95) }
  let(:bundle_5) { Bundle.new(5, 9.95) }
  let(:bundle_9) { Bundle.new(9, 16.99) }
  let(:product) { Product.new('Rockmelons', [bundle_3, bundle_5, bundle_9]) }

  describe '.add_product_line' do
    it 'adds a product line' do
      subject.add_product_line(ProductLine.new(2, product))
      expect(subject.children.size).to eql(1)
    end

    it 'does not add a product line' do
      subject.add_product_line(nil)
      expect(subject.children).to be_nil
    end
  end

  describe '.total_price' do
    it 'returns total when product lines exist' do
      total_1 = bundle_9.price + (2 * bundle_5.price) + bundle_3.price
      product_line_1 = ProductLine.new(9 + (2 * 5) + 3, product)
      product_line_1.fill!
      subject.add_product_line(product_line_1)

      total_2 = (2 * bundle_9.price) + bundle_5.price + bundle_3.price
      product_line_2 = ProductLine.new((2 * 9) + 5 + 3, product)
      product_line_2.fill!
      subject.add_product_line(product_line_2)

      expect(subject.children.size).to eql(2)
      expect(subject.total_price).to eql(BigDecimal(total_1 + total_2))
    end

    it 'returns total when a single product line exist' do
      total = 2 * bundle_5.price
      product_line = ProductLine.new(2 * 5, product)
      product_line.fill!
      subject.add_product_line(product_line)

      expect(subject.children.size).to eql(1)
      expect(subject.total_price).to eql(BigDecimal(total.to_s))
    end

    it 'returns 0 when order cannot be filled' do
      expect(subject.total_price).to eql(BigDecimal('0'))
    end
  end

  describe '.to_s' do
    it 'prints the output' do
      product_line = ProductLine.new(18, product)
      product_line.fill!
      subject.add_product_line(product_line)
      expect(subject.to_s).to include('18 Rockmelons $33.98')
      expect(subject.to_s).to include('2 x 9 pack @ $16.99')
      expect(subject.to_s).to include('TOTAL $33.98')
    end

    it 'prints an empty string if no children' do
      expect(subject.to_s).to eq('')
    end
  end
end