require 'spec_helper'

describe OrderLine do

  let(:bundle_3) { Bundle.new(3, 5.95) }
  let(:bundle_5) { Bundle.new(5, 9.95) }
  let(:bundle_9) { Bundle.new(9, 16.99) }
  let(:bundles) { [ bundle_3, bundle_5, bundle_9 ] }
  let(:subject) { OrderLine.new(10, bundle_5) }

  context 'attributes' do
    it { should respond_to :amount }
    it { should respond_to :bundle }
  end

  describe '#fill' do

    describe 'orders of a single bundle' do
      it 'calculates the order where it is a single of 9' do
        amount, order_lines = OrderLine.fill(9, bundles)
        expect(order_lines.size).to eql(1)
        expect(amount).to eql(0)

        order_line = order_lines[0]
        expect(order_line.amount).to eql(1)
        expect(order_line.bundle).to eql(bundle_9)
      end

      it 'calculates the order where it is a multiple of 9' do
        amount, order_lines = OrderLine.fill(9 * 3, bundles)
        expect(order_lines.size).to eql(1)
        expect(amount).to eql(0)

        order_line = order_lines[0]
        expect(order_line.amount).to eql(3)
        expect(order_line.bundle).to eql(bundle_9)
      end

      it 'calculates the order where it is a single of 5' do
        amount, order_lines = OrderLine.fill(5, bundles)
        expect(order_lines.size).to eql(1)
        expect(amount).to eql(0)

        order_line = order_lines[0]
        expect(order_line.amount).to eql(1)
        expect(order_line.bundle).to eql(bundle_5)
      end

      it 'calculates the order where it is a multiple of 5' do
        amount, order_lines = OrderLine.fill(5 * 2, bundles)

        expect(order_lines.size).to eql(1)
        expect(amount).to eql(0)

        order_line = order_lines[0]
        expect(order_line.amount).to eql(2)
        expect(order_line.bundle).to eql(bundle_5)
      end

      it 'calculates the order where it is a single of 3' do
        amount, order_lines = OrderLine.fill(3, bundles)

        expect(order_lines.size).to eql(1)
        expect(amount).to eql(0)

        order_line = order_lines[0]
        expect(order_line.amount).to eql(1)
        expect(order_line.bundle).to eql(bundle_3)
      end

      it 'calculates the order where it is a multiple of 3' do
        amount, order_lines = OrderLine.fill(3 * 2, bundles)

        expect(order_lines.size).to eql(1)
        expect(amount).to eql(0)

        order_line = order_lines[0]
        expect(order_line.amount).to eql(2)
        expect(order_line.bundle).to eql(bundle_3)
      end

      it 'does not calculate if the order cannot be filled' do
        amount, order_lines = OrderLine.fill(2, bundles)

        expect(order_lines.size).to eql(0)
        expect(amount).to eql(2)
      end
    end

    describe 'orders in combinations' do
      it 'calculates the order where it contains 1 bundle of 9, 2 bundles of 5, 1 bundle of 3' do
        amount, order_lines = OrderLine.fill(9 + (2*5) + 3, bundles)
        expect(order_lines.size).to eql(3)
        expect(amount).to eq(0)

        order_line = order_lines[0]
        expect(order_line.amount).to eql(1)
        expect(order_line.bundle).to eql(bundle_9)

        order_line = order_lines[1]
        expect(order_line.amount).to eql(2)
        expect(order_line.bundle).to eql(bundle_5)

        order_line = order_lines[2]
        expect(order_line.amount).to eql(1)
        expect(order_line.bundle).to eql(bundle_3)
      end

      it 'calculates the order where it contains 1 bundle of 9, 2 bundles of 5' do
        amount, order_lines = OrderLine.fill(9 + (2*5), bundles)
        expect(order_lines.size).to eql(2)
        expect(amount).to eq(0)

        order_line = order_lines[0]
        expect(order_line.amount).to eql(1)
        expect(order_line.bundle).to eql(bundle_9)

        order_line = order_lines[1]
        expect(order_line.amount).to eql(2)
        expect(order_line.bundle).to eql(bundle_5)
      end

      it 'calculates the order where it contains 1 bundle of 9, 2 bundles of 3' do
        amount, order_lines = OrderLine.fill(9 + (2*3), bundles)
        expect(order_lines.size).to eql(2)
        expect(amount).to eq(0)

        order_line = order_lines[0]
        expect(order_line.amount).to eql(1)
        expect(order_line.bundle).to eql(bundle_9)

        order_line = order_lines[1]
        expect(order_line.amount).to eql(2)
        expect(order_line.bundle).to eql(bundle_3)
      end

      it 'calculates the order where it contains 2 bundle of 5, 2 bundles of 3' do
        amount, order_lines = OrderLine.fill((2*5) + (2*3), bundles)
        expect(order_lines.size).to eql(2)
        expect(amount).to eq(0)

        order_line = order_lines[0]
        expect(order_line.amount).to eql(2)
        expect(order_line.bundle).to eql(bundle_5)

        order_line = order_lines[1]
        expect(order_line.amount).to eql(2)
        expect(order_line.bundle).to eql(bundle_3)
      end
    end
  end
end