require 'spec_helper'

describe Shop do

  let(:rose_bundle_5) { Bundle.new(5, 9.95) }
  let(:rose_bundle_10) { Bundle.new(10, 12.99) }
  let(:rose_bundles) { [ rose_bundle_5, rose_bundle_10 ] }
  let(:rose_product) { Product.new('R12', 'Roses', rose_bundles) }

  let(:lily_bundle_3) { Bundle.new(3, 9.95) }
  let(:lily_bundle_6) { Bundle.new(6, 16.95) }
  let(:lily_bundle_9) { Bundle.new(9, 24.95) }
  let(:lily_bundles) { [ lily_bundle_3, lily_bundle_6, lily_bundle_9 ] }
  let(:lily_product) { Product.new('L09', 'Lilies', lily_bundles) }

  let(:tulip_bundle_3) { Bundle.new(3, 5.95) }
  let(:tulip_bundle_5) { Bundle.new(5, 9.95) }
  let(:tulip_bundle_9) { Bundle.new(9, 16.99) }
  let(:tulip_bundles) { [ tulip_bundle_3, tulip_bundle_5, tulip_bundle_9 ] }
  let(:tulip_product) { Product.new('T58', 'Tulips', tulip_bundles) }

  let(:subject) { Shop.new([tulip_product, lily_product, rose_product]) }

  describe '.process_order' do
    it 'creates and fills an order' do
      order_lines = [ '10 R12', '15 L09', '13 T58' ]
      order = subject.process_order(order_lines)
      output = order.to_s

      expect(output).to include('10 R12 $12.99')
      expect(output).to include('1 x 10 $12.99')
      expect(output).to include('15 L09 $41.90')
      expect(output).to include('1 x 9 $24.95')
      expect(output).to include('1 x 6 $16.95')
      expect(output).to include('13 T58 $25.85')
      expect(output).to include('2 x 5 $19.90')
      expect(output).to include('1 x 3 $5.95')
    end

    it 'ignores bad orders' do
      order_lines = [ '10 R12', 'ABC', '13 T58' ]
      order = subject.process_order(order_lines)
      output = order.to_s

      expect(output).to include('10 R12 $12.99')
      expect(output).to include('1 x 10 $12.99')
      expect(output).to include('13 T58 $25.85')
      expect(output).to include('2 x 5 $19.90')
      expect(output).to include('1 x 3 $5.95')
    end

    it 'ignores no orders' do
      order = subject.process_order([])
      expect(order.to_s).to eq('')
    end
  end

end