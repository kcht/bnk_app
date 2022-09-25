module MySpotify
  class SongsBasedOnKeyword
    def get_songs(keyword:, limit:)
      spotify_client.search_by_keyword(keyword: keyword, limit: limit, accepted_genres: genres)
    end

    def genres
    end

    private

    def spotify_client
      @spotify_client ||= MySpotify::MySpotifyClient.new
    end
  end
end