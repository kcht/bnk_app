module MySpotify
  class MySpotifyClient
    def initialize
      # Sample configuration:
      config = {
        :access_token => ''
       :raise_errors => true, # choose between returning false or raising a proper exception when API calls fails

        # Connection properties
        :retries => 0, # automatically retry a certain number of times before returning
        :read_timeout => 10, # set longer read_timeout, default is 10 seconds
        :write_timeout => 10, # set longer write_timeout, default is 10 seconds
        :persistent => false # when true, make multiple requests calls using a single persistent connection. Use +close_connection+ method on the client to manually clean up sockets
      }
      @client = Spotify::Client2.new(config)
    end

    def client
      @client
    end

    # USAGE
    # sc = MySpotify::MySpotifyClient.new
    # uris = sc.search_by_keyword(keyword: "Dive")
    # sc.add_to_playlist_by_uris(uris) # do 2021-12-31


    def search_by_keyword(keyword:, accepted_genres: nil, type: :track, limit: 100)
      accepted_genres = ["rock",
                         "progressive rock",
                         "new wave",
                         "album rock",
                         "art rock",
                         "canterbury scene",
                         "flute rock",
                         "jazz fusion",
                         "symphonic rock",
                         "classic rock",
                         "mellow gold",
                         "soft rock",
                         "permanent wave",
                         "uk post-punk",
                         "beatlesque",
                         "folk rock",
                         "glam rock",
                         "compositional ambient",
                         "dream pop",
                         "ethereal wave",
                         "icelandic rock",
                         "melancholia",
                         "nordic post-rock",
                         "post-rock",
                         "neo classical metal",
                         "progressive metal",
                         "yacht rock",
                         "europop",
                         "swedish pop",
                         "glam metal",
                         "hard rock",
                         "swedish hard rock",
                         "swedish melodic rock",
                         "deep progressive rock",
                         "neo-progressive",
                         "norwegian prog",
                         "power metal",
                         "new romantic",
                         "new wave pop",
                         "sophisti-pop",
                         "synthpop"]


      binding.pry
      songs_to_add = []
      (0..5).each do |i|
        offset = i * 50

        list = client.search(:track, keyword, limit: 50, offset: offset)
        list["tracks"]["items"].each do |item|
          artist_id = item["album"]["artists"].first["id"]
          artists_genres = client.artists(artist_id)["artists"].first["genres"]
          common_genres = artists_genres & accepted_genres
          songs_to_add << item["uri"] unless common_genres.empty?
        end
      end

        songs_to_add
    end


    def search_song(title, artist)
      binding.pry

      @search_term = search_term(title, artist)
      results = client.search(:track, @search_term)


      @items = results["tracks"]["items"]
      # filtered = items.select do |record|
      #   artists_equal?(artist, record["artists"].first["name"])
      # end
      filtered = items
      # MySpotify::MySpotifyClient.new.add_to_playlist('She Said', 'BARCLAY JAMES HARVEST')
      #  MySpotify::ScanFromXls.add_to_playlist(100,0)
      filtered.first["uri"]

    end

    MEGACZART_ID ='2Cs4z17cQY3H0FddDIhUGi'
    TICKET_TO_THE_MOON_ID = '2HxzdxNw4YkWFYneLbcEGt'
    MY_ID= 's21y2foel7lpot2ev53fx5s2zq'
    SAMPLE_PLAYLIST_ID = '2nvmhLJ7NIKkYe1VQKMqEH'

    def add_to_playlist_by_uris(uris, playlist_id: SAMPLE_PLAYLIST_ID)
      uris.each do |uri|
        sleep(1)
        client.add_user_tracks_to_playlist(MY_ID, playlist_id, uri)
        puts '.'
      end

    end


    def add_to_playlist(title, artist)
      uri = search_song(title, artist)
      binding.pry
      uris = [uri]
      client.add_user_tracks_to_playlist(MY_ID, TICKET_TO_THE_MOON_ID, uris)
      puts "Added #{title}, #{artist}"
    rescue => e

      puts "#{e} Problem with searching for a track #{title}, #{artist}, found #{@items&.count} items, search_term: #{@search_term}"
      nil
    end

    private

    attr_reader :client, :items, :search_term

    def search_term(title, artist)
      if artist.include?(',')
        split = artist.split(',')
        artist = "#{split[1]} #{split[0]}"
      end

      "#{title} #{artist}"
    end

    def artists_equal?(artist_csv, artist_spotify)

      return true if artist_csv.casecmp(artist_spotify) == 0

      if artist_csv.include?(',')
        split = artist_csv.split(',')
        artist_csv = "#{split[1]} #{split[0]}"
      end
      return true if artist_csv.casecmp(artist_spotify) == 0


      return true if artist_spotify.casecmp('B.B.King') && artist_csv.casecmp('BB King')
      return true if artist_spotify.casecmp('Grzegorz Szczepaniak') && artist_csv.casecmp('ABC / GRZEGORZ SZCZEPANIAK')
    end
  end

end