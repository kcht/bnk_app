require 'rails_helper'

RSpec.describe ProgramInfos::DetermineFilename, type: :service do
  describe '#call' do
    subject { described_class.new(program_number).call }

    before do
      fixtures_path = 'spec/fixtures/files/determine_filename'
      stub_const('ProgramInfos::DetermineFilename::BNK_DATA_PATH', fixtures_path)
    end

    context 'when bnk playlist with given number is present' do
      let(:program_number) { 40 }

      it 'returns correct filename' do
        expect(subject).to eq('spec/fixtures/files/determine_filename/bnk_040_something')
      end
    end

    context 'when file with given number is not present' do
      let(:program_number) { 2 }

      it { is_expected.to be nil }
    end
  end
end
