# songs = Song.pluck(:artist).uniq.map do |artist|
#    { artist => PlaylistItem.joins(:song).where(songs: {artist: artist }).count }
# end
#
# ilosc granych utworow (z dupliaktami)
# bnk_dev=# select s.artist, count(*) from playlist_infos
#     # left join songs s on s.id = playlist_infos.song_id group
#     # by artist order by count(*) desc;
#
# piosenki grane wiecej niz raz
# bnk_dev=# select s.title, s.artist from songs s
# # join playlist_infos pi on  pi.song_id = s.id group by s.title, s.artist having count(*) >1 ;
#
