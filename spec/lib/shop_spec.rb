require 'spec_helper'

describe Shop do

  let(:bundle_3) { Bundle.new(3, 5.95) }
  let(:bundle_5) { Bundle.new(5, 9.95) }
  let(:bundle_9) { Bundle.new(9, 16.99) }
  let(:bundles) { [ bundle_3, bundle_5, bundle_9 ] }
  let(:product) { Product.new('T58', 'Tulips', bundles) }
  let(:subject) { Shop.new([product]) }

  context 'attributes' do
    it { should respond_to :products }
  end

  describe '.products' do
    it 'returns a product based on code' do
      expect(subject.products['T58']).to eq(product)
    end
  end

end