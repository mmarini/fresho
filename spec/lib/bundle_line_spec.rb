require 'spec_helper'

describe BundleLine do

  let(:bundle_3) { Bundle.new(3, 5.95) }
  let(:bundle_5) { Bundle.new(5, 9.95) }
  let(:bundle_9) { Bundle.new(9, 16.99) }
  let(:bundles) { [ bundle_3, bundle_5, bundle_9 ] }
  let(:subject) { BundleLine.new(10, bundle_5) }

  context 'attributes' do
    it { should respond_to :amount }
    it { should respond_to :size }
    it { should respond_to :price }
  end

  describe '#fill' do

    describe 'orders of a single bundle' do
      it 'calculates the order where it is a single of 9' do
        amount, bundle_lines = BundleLine.fill(9, bundles)
        expect(bundle_lines.size).to eql(1)
        expect(amount).to eql(0)

        bundle_line = bundle_lines[0]
        expect(bundle_line.amount).to eql(1)
        expect(bundle_line.size).to eql(9)
        expect(bundle_line.price).to eql(BigDecimal('16.99'))
      end

      it 'calculates the order where it is a multiple of 9' do
        amount, bundle_lines = BundleLine.fill(9 * 3, bundles)
        expect(bundle_lines.size).to eql(1)
        expect(amount).to eql(0)

        bundle_line = bundle_lines[0]
        expect(bundle_line.amount).to eql(3)
        expect(bundle_line.size).to eql(9)
        expect(bundle_line.price).to eql(BigDecimal('16.99'))
      end

      it 'calculates the order where it is a single of 5' do
        amount, bundle_lines = BundleLine.fill(5, bundles)
        expect(bundle_lines.size).to eql(1)
        expect(amount).to eql(0)

        bundle_line = bundle_lines[0]
        expect(bundle_line.amount).to eql(1)
        expect(bundle_line.size).to eql(5)
        expect(bundle_line.price).to eql(BigDecimal('9.95'))
      end

      it 'calculates the order where it is a multiple of 5' do
        amount, bundle_lines = BundleLine.fill(5 * 2, bundles)

        expect(bundle_lines.size).to eql(1)
        expect(amount).to eql(0)

        bundle_line = bundle_lines[0]
        expect(bundle_line.amount).to eql(2)
        expect(bundle_line.size).to eql(5)
        expect(bundle_line.price).to eql(BigDecimal('9.95'))
      end

      it 'calculates the order where it is a single of 3' do
        amount, bundle_lines = BundleLine.fill(3, bundles)

        expect(bundle_lines.size).to eql(1)
        expect(amount).to eql(0)

        bundle_line = bundle_lines[0]
        expect(bundle_line.amount).to eql(1)
        expect(bundle_line.size).to eql(3)
        expect(bundle_line.price).to eql(BigDecimal('5.95'))
      end

      it 'calculates the order where it is a multiple of 3' do
        amount, bundle_lines = BundleLine.fill(3 * 2, bundles)

        expect(bundle_lines.size).to eql(1)
        expect(amount).to eql(0)

        bundle_line = bundle_lines[0]
        expect(bundle_line.amount).to eql(2)
        expect(bundle_line.size).to eql(3)
        expect(bundle_line.price).to eql(BigDecimal('5.95'))
      end

      it 'does not calculate if the order cannot be filled' do
        amount, bundle_lines = BundleLine.fill(2, bundles)

        expect(bundle_lines.size).to eql(0)
        expect(amount).to eql(2)
      end
    end

    describe 'orders in combinations' do
      it 'calculates the order where it contains 1 bundle of 9, 2 bundles of 5, 1 bundle of 3' do
        amount, bundle_lines = BundleLine.fill(9 + (2*5) + 3, bundles)
        expect(bundle_lines.size).to eql(3)
        expect(amount).to eq(0)

        bundle_line = bundle_lines[0]
        expect(bundle_line.amount).to eql(1)
        expect(bundle_line.size).to eql(9)
        expect(bundle_line.price).to eql(BigDecimal('16.99'))

        bundle_line = bundle_lines[1]
        expect(bundle_line.amount).to eql(2)
        expect(bundle_line.size).to eql(5)
        expect(bundle_line.price).to eql(BigDecimal('9.95'))

        bundle_line = bundle_lines[2]
        expect(bundle_line.amount).to eql(1)
        expect(bundle_line.size).to eql(3)
        expect(bundle_line.price).to eql(BigDecimal('5.95'))
      end

      it 'calculates the order where it contains 1 bundle of 9, 2 bundles of 5' do
        amount, bundle_lines = BundleLine.fill(9 + (2*5), bundles)
        expect(bundle_lines.size).to eql(2)
        expect(amount).to eq(0)

        bundle_line = bundle_lines[0]
        expect(bundle_line.amount).to eql(1)
        expect(bundle_line.size).to eql(9)
        expect(bundle_line.price).to eql(BigDecimal('16.99'))

        bundle_line = bundle_lines[1]
        expect(bundle_line.amount).to eql(2)
        expect(bundle_line.size).to eql(5)
        expect(bundle_line.price).to eql(BigDecimal('9.95'))
      end

      it 'calculates the order where it contains 1 bundle of 9, 2 bundles of 3' do
        amount, bundle_lines = BundleLine.fill(9 + (2*3), bundles)
        expect(bundle_lines.size).to eql(2)
        expect(amount).to eq(0)

        bundle_line = bundle_lines[0]
        expect(bundle_line.amount).to eql(1)
        expect(bundle_line.size).to eql(9)
        expect(bundle_line.price).to eql(BigDecimal('16.99'))

        bundle_line = bundle_lines[1]
        expect(bundle_line.amount).to eql(2)
        expect(bundle_line.size).to eql(3)
        expect(bundle_line.price).to eql(BigDecimal('5.95'))
      end

      it 'calculates the order where it contains 2 bundle of 5, 2 bundles of 3' do
        amount, bundle_lines = BundleLine.fill((2*5) + (2*3), bundles)
        expect(bundle_lines.size).to eql(2)
        expect(amount).to eq(0)

        bundle_line = bundle_lines[0]
        expect(bundle_line.amount).to eql(2)
        expect(bundle_line.size).to eql(5)
        expect(bundle_line.price).to eql(BigDecimal('9.95'))

        bundle_line = bundle_lines[1]
        expect(bundle_line.amount).to eql(2)
        expect(bundle_line.size).to eql(3)
        expect(bundle_line.price).to eql(BigDecimal('5.95'))
      end
    end
  end

  describe '.total' do
    it 'outputs the total' do
      expect(subject.total).to eql(99.50)
    end
  end

  describe '.to_s' do
    it 'outputs the bundle breakdown' do
      expect(subject.to_s).to eql('10 x 5 $9.95')
    end
  end

  describe '.+' do
    it 'adds two bundle lines together' do
      bundle_line_1 = BundleLine.new(3, bundle_5)
      bundle_line_2 = BundleLine.new(2, bundle_3)

      expect(bundle_line_1 + bundle_line_2).to eq(BigDecimal.new('41.75'))
    end
  end

end