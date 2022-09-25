module MySpotify
  class PlaylistPopulator
    MEGACZART_ID ='2Cs4z17cQY3H0FddDIhUGi'
    TICKET_TO_THE_MOON_PLAYLIST_ID = '2HxzdxNw4YkWFYneLbcEGt'
    SAMPLE_PLAYLIST_ID = '2nvmhLJ7NIKkYe1VQKMqEH'

    USER_ID = 's21y2foel7lpot2ev53fx5s2zq'

    def initialize(song_list:)
      @playlist_code = playlist_code
      @song_list = song_list
    end

    def call
      binding.pry
      spotify_client =  MySpotify::MySpotifyClient.new
      song_list.each do |song|

        client.add_user_tracks_to_playlist(USER_ID, SAMPLE_PLAYLIST_ID, uris)
        puts "Added #{song}"
      rescue => e

        puts "#{e} Problem with searching for a track #{song}, found #{@items&.count} items"
        nil

      end


    end

    private

    attr_reader :song_list, :playlist_code

  end
end