require 'active_support'

module ProgramsHelper
  include ActionView::Helpers::UrlHelper
  extend self

  def display_link_to_podcast(link_to_podcast)
    return unless link_to_podcast
    link_to "Posłuchaj podcastu", link_to_podcast
  end

  def title_for_program_list
    tag = Tag.where(id: params[:tag])
    if tag.present?
      "All programs with tag '#{tag.name}'"
    else
      return "All BNK programs"
    end
  end


  def playlist_info(program_number:)
    playlist = PlaylistItem.where(program_id: program_id(program_number))
    playlist_items = []
    playlist.each do |playlist_item|
      song = Song.find(playlist_item.song_id)
      item = {title: song.title, artist: song.artist, album: song.album, year: song.year, position: playlist_item.position}
      playlist_items << item
    end
    playlist_items
  end

  def self.save_song_to_playlist!(song_id:, program_number:)
    program_id = program_id(program_number)
    current_max_postion = PlaylistItem.where(program_id: program_id).map(&:position).select {|e| !e.nil?}.max
    position = (current_max_postion.nil?) ? 1 : current_max_postion +1
    PlaylistItem.new(program_id: program_id, song_id: song_id, position: position).save!
  end

  private

  def program_id(program_number)
    Program.where(number: program_number).first.id
  end

end
