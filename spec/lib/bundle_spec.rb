require 'spec_helper'

describe Bundle do

  let(:subject) { Bundle.new(3, 5.95) }

  context 'attributes' do
    it { should respond_to :size }
    it { should respond_to :price }

    describe '.price' do
      it 'is a BigDecimal' do
        expect(subject.price).to be_instance_of(BigDecimal)
      end
    end

  end

  describe '#sort_by_size' do
    it 'sorts the bundles by size in descending order' do
      bundle_1 = Bundle.new(3, 5.95)
      bundle_2 = Bundle.new(5, 5.95)
      bundle_3 = Bundle.new(9, 5.95)

      bundles = [ bundle_2, bundle_1, bundle_3 ]

      sorted_bundles = Bundle.sort_by_size(bundles)

      expect(sorted_bundles).to eq( [ bundle_3, bundle_2, bundle_1 ] )
    end
  end

end