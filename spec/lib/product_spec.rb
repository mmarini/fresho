require 'spec_helper'

describe Product do

  let(:bundle_3) { Bundle.new(3, 5.95) }
  let(:bundle_5) { Bundle.new(5, 9.95) }
  let(:bundle_9) { Bundle.new(9, 16.99) }
  let(:bundles) { [ bundle_3, bundle_5, bundle_9 ] }
  let(:subject) { Product.new('T58', 'Tulips', bundles) }

  context 'attributes' do
    it { should respond_to :code }
    it { should respond_to :bundles }
  end

end