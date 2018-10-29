require 'rails_helper'

RSpec.describe ProgramInfos::InsertIntoDb, type: :service do
  describe '.call' do
    subject {described_class.new(program_info_hash).call}

    let(:program_info_hash) do
      {
          number: 1,
          title: 'title',
          date: '2018-01-01',
          description: 'description',
          playlist: [{
                         number: 1,
                         artist: 'artist',
                         title: 'title',
                         album: 'album',
                         year: '2018'
                     },
                     {
                         number: 2,
                         artist: 'artist2',
                         title: 'title2',
                         album: 'album2',
                         year: '2018'
                     }]
      }
    end

    context 'when adding a new info to the db' do
      it 'creates new program record' do
        expect {subject}.to change {Program.count}.from(0).to(1)
      end

      it 'creates 2 new song records' do
        expect {subject}.to change {Song.count}.from(0).to(2)
      end

      it 'creates 2 records in PlaylistItem' do
        expect {subject}.to change {PlaylistItem.count}.from(0).to(2)
      end
    end

    context 'when info about the program is already in the db with the same data' do
      let!(:program) {Program.create!(number: 1, name: 'title', date: '2018-01-01', description: 'description')}
      let!(:song1) {Song.create!(title: 'title', artist: 'artist', album: 'album', year: '2018')}
      let!(:song2) {Song.create!(title: 'title2', artist: 'artist2', album: 'album2', year: '2018')}
      let!(:playlist_info1) {PlaylistItem.create!(program_id: program.id, song_id: song1.id, position: 1)}
      let!(:playlist_info2) {PlaylistItem.create!(program_id: program.id, song_id: song2.id, position: 2)}

      it 'does not create new program record' do
        expect {subject}.not_to change{Program.count}
      end

      it 'does not create 2 new song records' do
        expect {subject}.not_to change{Song.count}
      end

      it 'does not create 2 records in PlaylistItem' do
        expect {subject}.not_to change{PlaylistItem.count}
      end

      it 'does not update program record' do
        expect {subject; program.reload}.not_to change{program}
      end

      it 'does not update song records' do
        expect {subject; song1.reload}.not_to change{song1}
      end
    end

    context 'when updating data' do
      let!(:program) {Program.create!(number: 1, name: 'old title', date: '2017-01-01', description: 'old')}
      let!(:song1) {Song.create!(title: 'old', artist: 'old song', album: 'album', year: '2018')}
      let!(:song2) {Song.create!(title: 'title2', artist: 'artist2', album: 'album2', year: '2018')}
      let!(:playlist_info1) {PlaylistItem.create!(program_id: program.id, song_id: song1.id, position: 1)}
      let!(:playlist_info2) {PlaylistItem.create!(program_id: program.id, song_id: song2.id, position: 3)}

      it 'does not new program record' do
        expect {subject}.not_to change{Program.count}
      end

      it 'creates 1 new song records' do
        expect {subject}.to change{Song.count}.from(2).to(3)
      end

      it 'does not create 2 records in PlaylistItem' do
        expect {subject}.to change{PlaylistItem.count}.from(2).to(3)
      end

      it 'updates program record' do
        expect {subject; program.reload}.to change{program.name}.to('title')
      end

      it 'does not update song records (but creates a new one)' do
        expect {subject; song1.reload}.not_to change{song1}
      end

      it 'updates playlist info - song position only' do
        expect{subject; playlist_info2.reload}.to change {playlist_info2.position}.from(3).to(2)
      end
    end
  end
end