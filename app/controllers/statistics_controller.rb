class StatisticsController < ApplicationController
  def mostly_played
    @artists_with_song_count = mostly_played_artists(limit: 10)
  end

  private

  def mostly_played_artists(limit:)
    sql_string = %Q{
      select s.artist, count(*) from playlist_items
      left join songs s on s.id = playlist_items.song_id
      group by artist order by count(*) desc limit #{limit}}
    ActiveRecord::Base.connection.execute(sql_string).values
  end
end

