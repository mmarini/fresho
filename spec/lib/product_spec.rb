require 'spec_helper'

describe Product do

  let(:bundle_5) { Bundle.new(5, 16.95) }
  let(:bundle_8) { Bundle.new(8, 24.95) }
  let(:bundles) { [ bundle_5, bundle_8 ] }
  let(:subject) { Product.new('Pineapples', bundles) }

  context 'attributes' do
    it { should respond_to :name }
    it { should respond_to :bundles }
  end

end