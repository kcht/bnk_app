require 'csv'

module MySpotify
  class ScanFromXls
    FILENAME = '/Users/kchachlowska/private/bnk_app/app/assets/xls/megaczart2020.csv'

    def self.add_to_playlist(limit, offset)
      csv = CSV.read(FILENAME)
      from = offset
      to = offset + limit

      rows = csv[from..to]
      rows.each do |row|
        artist = row.first
        title = row.second

        client.add_to_playlist(title, artist)
      end; 0
    end


    def self.client
      @client ||= MySpotifyClient.new
    end
  end
end


