module MySpotify
  class SongsBasedOnKeyword
    def get_songs(keyword:, limit:)

    end

    private

    def spotify_client
      @spotify_client ||= MySpotify::MySpotifyClient.new
    end
  end
end