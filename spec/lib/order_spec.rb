require 'spec_helper'

describe Order do

  let(:bundle_3) { Bundle.new(3, 5.95) }
  let(:bundle_5) { Bundle.new(5, 9.95) }
  let(:bundle_9) { Bundle.new(9, 16.99) }
  let(:bundles) { [ bundle_3, bundle_5, bundle_9 ] }
  let(:product) { Product.new('T58', 'Tulips', bundles) }
  let(:subject) { Order.new(10, product) }

  context 'attributes' do
    it { should respond_to :amount }
    it { should respond_to :product }
    it { should respond_to :order_lines }
  end

  describe '.fill' do
    it 'fills the order where it can' do
      subject.fill(bundles)
      expect(subject.order_lines.size).to eql(1)
    end

    it 'does not fill the order if it cannot' do
      order = Order.new(1, product)
      order.fill(bundles)
      expect(order.order_lines.size).to eql(0)
    end
  end

end