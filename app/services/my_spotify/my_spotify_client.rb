module MySpotify
  class MySpotifyClient
    def initialize
      # Sample configuration:
      config = {
        :access_token => 'BQCSx8ql4fkui73Yb4K6m2ae3hjdCyMCSGES1L4OoMgjSCrIOvmNyTIp_8tnPYj9Q62JHx2Nr6ZvCX5M05Zxx6tu0rMueaFxp494y44Mw5xIrFWtQ2IxBWh66u89dku-1NXBufcEptg9QaR4oLr3LwJVZ2DXKG5z1DYJzfUDQLvTV-XewqPdzAuIcbgQX67KSpoLirkOVsqpqrfLtGKmaKiZFDpXj5kjcEhq5WErYuAW3vCvuIcjlfi07pJr7LPy',
        :raise_errors => true, # choose between returning false or raising a proper exception when API calls fails

        # Connection properties
        :retries => 0, # automatically retry a certain number of times before returning
        :read_timeout => 10, # set longer read_timeout, default is 10 seconds
        :write_timeout => 10, # set longer write_timeout, default is 10 seconds
        :persistent => false # when true, make multiple requests calls using a single persistent connection. Use +close_connection+ method on the client to manually clean up sockets
      }
      @client = Spotify::Client.new(config)
    end

    def client
      @client
    end

    def search(query:, type: :track, limit: 100)
      client.search(type, query, )
    end

    def search(title, artist)
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
    TICKET_TO_THE_MOON_ID = ''
    MY_ID= 's21y2foel7lpot2ev53fx5s2zq'

    def add_to_playlist(title, artist)
      uri = search(title, artist)
      uris = [uri]
      client.add_user_tracks_to_playlist(MY_ID, MEGACZART_ID, uris)
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