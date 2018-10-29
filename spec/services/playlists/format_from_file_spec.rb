require 'rails_helper'

RSpec.describe Playlists::FormatFromFile, type: :service do
  describe '#call' do
    subject { described_class.new(number: 1).call }

    before do
      allow_any_instance_of(ProgramInfos::DetermineFilename).to receive(:call).and_return(filename)
    end

    context 'for non-existent program' do
      let(:filename) { 'spec/fixtures/files/playlists/xxxxxxx' }

      it { is_expected.to be_failure }
    end


    context 'when file exists' do
      context 'for too many semicolons' do
        let(:filename) { 'spec/fixtures/files/playlists/additional_semicolons' }

        it 'is successful nonetheless' do
          songs = subject.value!
          expect(songs.count).to eq(3)
        end
      end

      context 'for empty basic info' do
        let(:filename) { 'spec/fixtures/files/playlists/empty_basic_info' }

        it 'is successful nonetheless' do
          songs = subject.value!
          expect(songs.count).to eq(3)
        end
      end

      context 'for empty playlist' do
        let(:filename) { 'spec/fixtures/files/playlists/empty_playlist' }

        it 'is successful nonetheless' do
          songs = subject.value!
          expect(songs.count).to eq(0)
        end
      end

      context 'for missing colons after number' do
        let(:filename) { 'spec/fixtures/files/playlists/empty_basic_info' }

        it 'is successful nonetheless' do
          songs = subject.value!
          expect(songs.count).to eq(3)
        end
      end

      context 'for missing numbers' do
        let(:filename) { 'spec/fixtures/files/playlists/missing_numbers' }

        it 'is successful nonetheless but returns empty playlist' do
          songs = subject.value!
          expect(songs.count).to eq(0)
        end
      end

      context 'for well-formatted file' do
        let(:filename) { 'spec/fixtures/files/playlists/ok_number_one_three_entries' }

        it 'is successful nonetheless' do
          songs = subject.value!
          expect(songs.count).to eq(3)
        end
      end
    end
  end
end