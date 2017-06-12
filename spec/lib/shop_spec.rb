require 'spec_helper'

describe Shop do

  let(:watermelon_bundle_3) { Bundle.new(3, 6.99) }
  let(:watermelon_bundle_5) { Bundle.new(5, 8.99) }
  let(:watermelon_bundles) { [watermelon_bundle_3, watermelon_bundle_5 ] }
  let(:watermelon_product) { Product.new('Watermelons', watermelon_bundles) }

  let(:pineapple_bundle_2) { Bundle.new(2, 9.95) }
  let(:pineapple_bundle_5) { Bundle.new(5, 16.95) }
  let(:pineapple_bundle_8) { Bundle.new(8, 24.95) }
  let(:pineapple_bundles) { [pineapple_bundle_2, pineapple_bundle_5, pineapple_bundle_8 ] }
  let(:pineapple_product) { Product.new('Pineapples', pineapple_bundles) }

  let(:rockmelon_bundle_3) { Bundle.new(3, 5.95) }
  let(:rockmelon_bundle_5) { Bundle.new(5, 9.95) }
  let(:rockmelon_bundle_9) { Bundle.new(9, 16.99) }
  let(:rockmelon_bundles) { [rockmelon_bundle_3, rockmelon_bundle_5, rockmelon_bundle_9 ] }
  let(:rockmelon_product) { Product.new('Rockmelons', rockmelon_bundles) }

  let(:subject) { Shop.new([rockmelon_product, pineapple_product, watermelon_product]) }

  describe '.process_order' do
    it 'creates and fills an order' do
      order_lines = [ '10 Watermelons', '14 Pineapples', '13 Rockmelons' ]
      order = subject.process_order(order_lines)
      output = order.to_s

      expect(output).to include('10 Watermelons $17.98')
      expect(output).to include('2 x 5 pack @ $8.99')
      expect(output).to include('14 Pineapples $54.80')
      expect(output).to include('1 x 8 pack @ $24.95')
      expect(output).to include('3 x 2 pack @ $9.95')
      expect(output).to include('13 Rockmelons $25.85')
      expect(output).to include('2 x 5 pack @ $9.95')
      expect(output).to include('1 x 3 pack @ $5.95')
    end

    it 'ignores bad orders' do
      order_lines = [ '10 Watermelons', 'Blueberries', '13 Rockmelons' ]
      order = subject.process_order(order_lines)
      output = order.to_s

      expect(output).to include('10 Watermelons $17.98')
      expect(output).to include('2 x 5 pack @ $8.99')
      expect(output).to include('13 Rockmelons $25.85')
      expect(output).to include('2 x 5 pack @ $9.95')
      expect(output).to include('1 x 3 pack @ $5.95')
    end

    it 'ignores no orders' do
      order = subject.process_order([])
      expect(order.to_s).to eq('')
    end
  end

end