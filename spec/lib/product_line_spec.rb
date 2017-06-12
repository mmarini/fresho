require 'spec_helper'

describe ProductLine do

  let(:bundle_3) { Bundle.new(3, 5.95) }
  let(:bundle_5) { Bundle.new(5, 9.95) }
  let(:bundle_9) { Bundle.new(9, 16.99) }
  let(:bundles) { [ bundle_3, bundle_5, bundle_9 ] }
  let(:product) { Product.new('Rockmelons', bundles) }
  let(:subject) { ProductLine.new(10, product) }

  context 'attributes' do
    it { should respond_to :amount }
    it { should respond_to :product }
    it { should respond_to :bundle_lines }
  end

  describe '.fill' do
    it 'fills the order where it can' do
      subject.fill!
      expect(subject.bundle_lines.size).to eql(1)
    end

    it 'does not fill the order if it cannot' do
      product_line = ProductLine.new(1, product)
      product_line.fill!
      expect(product_line.bundle_lines.size).to eql(0)
    end
  end

  describe '.filled?' do
    it 'returns true when bundle lines exist' do
      subject.fill!
      expect(subject.filled?).to be true
    end

    it 'returns false when bundle lines do not exist' do
      product_line = ProductLine.new(1, product)
      product_line.fill!
      expect(product_line.filled?).to be false
    end
  end

  describe '.total_summary' do
    it 'returns total line for a single line' do
      total = 2 * bundle_5.price
      product_line = ProductLine.new(2 * 5, product)
      product_line.fill!
      expect(product_line.total_summary).to eql('10 Rockmelons $19.90')
    end

    it 'returns total line for multiple lines' do
      total = bundle_9.price + (2 * bundle_5.price) + bundle_3.price
      product_line = ProductLine.new(9 + (2 * 5) + 3, product)
      product_line.fill!
      expect(product_line.total_summary).to eql('22 Rockmelons $42.84')
    end
  end

  describe '.total_price' do
    it 'returns total when bundle lines exist' do
      total = bundle_9.price + (2 * bundle_5.price) + bundle_3.price
      product_line = ProductLine.new(9 + (2 * 5) + 3, product)
      product_line.fill!
      expect(product_line.bundle_lines.size).to eql(3)
      expect(product_line.total_price).to eql(BigDecimal(total.to_s))
    end

    it 'returns total when a single bundle line exist' do
      total = 2 * bundle_5.price
      product_line = ProductLine.new(2 * 5, product)
      product_line.fill!
      expect(product_line.bundle_lines.size).to eql(1)
      expect(product_line.total_price).to eql(BigDecimal(total.to_s))
    end

    it 'returns 0 when order cannot be filled' do
      product_line = ProductLine.new(2, product)
      product_line.fill!
      expect(product_line.bundle_lines.size).to eql(0)
      expect(product_line.total_price).to eql(BigDecimal('0'))
    end
  end

  describe '.to_s' do
    it 'prints the total line' do
      total = bundle_9.price + (2 * bundle_5.price) + bundle_3.price
      product_line = ProductLine.new(9 + (2 * 5) + 3, product)
      product_line.fill!
      expect(product_line.to_s).to include('22 Rockmelons $42.84')
    end

    it 'prints the bundle lines' do
      total = bundle_9.price + (2 * bundle_5.price) + bundle_3.price
      product_line = ProductLine.new(9 + (2 * 5) + 3, product)
      product_line.fill!
      expect(product_line.to_s).to include('1 x 9 pack @ $16.99')
      expect(product_line.to_s).to include('2 x 5 pack @ $9.95')
      expect(product_line.to_s).to include('1 x 3 pack @ $5.95')
    end
  end
end