require 'spec_helper'

describe Order do

  let(:bundle) { Bundle.new(9, 16.99) }
  let(:product) { Product.new('Rockmelons', [bundle]) }

  describe '.add_product_line' do
    it 'adds a product line' do
      subject.add_product_line(ProductLine.new(2, product))
      expect(subject.product_lines.size).to eql(1)
    end

    it 'does not add a product line' do
      subject.add_product_line(nil)
      expect(subject.product_lines.size).to eql(0)
    end
  end

  describe '.to_s' do
    it 'prints the output' do
      product_line = ProductLine.new(18, product)
      product_line.fill!
      subject.add_product_line(product_line)
      expect(subject.to_s).to include('18 Rockmelons $33.98')
      expect(subject.to_s).to include('2 x 9 pack @ $16.99')
    end
  end
end