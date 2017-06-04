require 'spec_helper'

describe ProductOrderRequest do

  let (:subject) { ProductOrderRequest.new('4 R12')}

  context 'attributes' do
    it { should respond_to :product_code }

    it { should respond_to :amount }
    it 'returns amount as an integer' do
      expect(subject.amount).to eq(4)
    end

  end

  describe '.is_valid?' do
    it 'is valid with an amount and a product code' do
      expect(subject.is_valid?).to be true
    end

    it 'is not valid with an amount only' do
      expect(ProductOrderRequest.new('4').is_valid?).to be false
    end

    it 'is not valid with a non integer amount' do
      expect(ProductOrderRequest.new('A R12').is_valid?).to be false
      expect(ProductOrderRequest.new('4.2 R12').is_valid?).to be false
    end

    it 'is not valid with an code only' do
      expect(ProductOrderRequest.new('R12').is_valid?).to be false
    end
  end
end