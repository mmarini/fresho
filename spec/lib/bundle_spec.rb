require 'spec_helper'

describe Bundle do

  let(:subject) { Bundle.new(3, 5.95) }

  context 'attributes' do
    it { should respond_to :size }
    it { should respond_to :price }
  end

end