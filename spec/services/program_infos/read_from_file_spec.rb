require 'rails_helper'

RSpec.describe ProgramInfos::ReadFromFile, type: :service do
  describe '.call' do
    before do

    end

    subject { described_class.new(filename).call }

    context 'for nonexistent file in filepath' do
      let(:filename) { 'spec/fixtures/files/playlists/blablabla' }

      it 'returns error' do
        expect{ subject }.to raise_error(FileNotFoundError)
      end

    end

    context 'with correctly formatted playlist' do
      let(:filename) { 'spec/fixtures/files/playlists/ok_number_one_three_entries' }

      it 'contains hash with correct keys', :aggregate_failures do
        keys = subject.keys
        expect(keys).to include(:number, :title, :date, :description, :playlist)
        expect(keys.size).to eq(5)
      end

      it 'playlist hash contains  correct keys', :aggregate_failures do
        keys = subject[:playlist][0].keys
        expect(keys).to include(:number, :artist, :title, :album, :year)
        expect(keys.size).to eq(5)
      end

      it 'contains correct data in hash', :aggregate_failures do
        expect(subject[:number]).to eq('1')
        expect(subject[:title]).to eq('Something')
        expect(subject[:date]).to eq('2018-03-19')
        expect(subject[:description]).to eq('Something')
        expect(subject[:playlist].size).to eq(3)
        expect(subject[:playlist][0][:number]).to eq(1)
        expect(subject[:playlist][1][:number]).to eq(2)
        expect(subject[:playlist][2][:number]).to eq(3)
        expect(subject[:playlist][0][:title]).to eq('Test')
        expect(subject[:playlist][1][:title]).to eq('Rainbow Eyes')
        expect(subject[:playlist][2][:title]).to eq('The Temple Of The King')
        expect(subject[:playlist][0][:artist]).to eq('Led Zeppelin')
        expect(subject[:playlist][1][:artist]).to eq('Rainbow')
        expect(subject[:playlist][2][:artist]).to eq('Rainbow')
        expect(subject[:playlist][0][:album]).to eq('Dukes Of The Orient')
        expect(subject[:playlist][1][:album]).to eq("Long Live Rock 'n' Roll")
        expect(subject[:playlist][2][:album]).to eq("Ritchie Blackmore's Rainbow")
        expect(subject[:playlist][0][:year]).to eq('2018')
        expect(subject[:playlist][1][:year]).to eq('1978')
        expect(subject[:playlist][2][:year]).to eq('1975')
      end
    end
  end
end