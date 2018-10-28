module Songs
  class Statistics
    def songs_played_more_than_once
      sql_string = %Q{
        SELECT s.title, s.artist, count(*) FROM songs s
        JOIN playlist_infos pi on pi.song_id = s.id
        GROUP BY s.title, s.artist
        HAVING count(*) > 1
      }
      ActiveRecord::Base.connection.execute(sql_string).values
    end

  end
end