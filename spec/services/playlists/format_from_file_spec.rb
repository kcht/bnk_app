require 'rails_helper'

RSpec.describe Playlists::FormatFromFile, type: :service do
  describe '#call' do
    subject { described_class.new(number: 1).call }

    before do

    end

    context 'for non-existant program' do
      let(:filename) { 'xxxxxxx' }

      it { is_expected.to be_failure }

      it 'returns failure for non-existent file' do
        expect(subject.failure).to eq('file doesnt exist')
      end
    end


    context 'when file exists' do
      context 'for too many semicolons' do
        let(:filename) { 'additional_semicolons' }

        it 'is successful nonetheless' do
          songs = subject.value!
          expect(songs.count).to eq(3)
        end
      end

      context 'for empty basic info' do
        let(:filename) { 'empty_basic_info' }

        it 'is successful nonetheless' do
          songs = subject.value!
          expect(songs.count).to eq(3)
        end
      end

      context 'for empty playlist' do
        let(:filename) { 'empty_playlist' }

        it 'is successful nonetheless' do
          songs = subject.value!
          expect(songs.count).to eq(0)
        end
      end

      context 'for missing colons after number' do
        let(:filename) { 'empty_basic_info' }

        it 'is successful nonetheless' do
          songs = subject.value!
          expect(songs.count).to eq(3)
        end
      end

      context 'for missing numbers' do
        let(:filename) { 'missing_numbers' }

        it 'is successful nonetheless but returns empty playlist' do
          songs = subject.value!
          expect(songs.count).to eq(0)
        end
      end

      context 'for well-formatted file' do
        let(:filename) { 'ok_number_one_three_entries' }

        it 'is successful nonetheless' do
          songs = subject.value!
          expect(songs.count).to eq(3)
        end
      end
    end
  end
end