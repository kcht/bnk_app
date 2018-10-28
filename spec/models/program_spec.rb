require 'rails_helper'

RSpec.describe Program do

  describe 'program_infos save' do
    let(:program_name) { 'Valid name' }
    let(:program_number) { 1 }
    subject(:save) { described_class.new(number: program_number, name: program_name).save! }


    context 'when name is too short' do
      let(:program_name) { 'x' }

      it 'does not save program_infos' do
        expect { save }.to raise_error(StandardError)
      end
    end

    context 'when name is missing' do
      let(:program_name) { nil }

      it 'does not save program_infos' do
        expect { save }.to raise_error(StandardError)
      end
    end

    context 'when number is missing' do
      let(:program_name) { nil }

      it 'does not save program_infos' do
        expect { save }.to raise_error(StandardError)
      end
    end

    context 'when all parameters are valid' do
      it { expect{ save }.not_to raise_error }
    end
  end
end

