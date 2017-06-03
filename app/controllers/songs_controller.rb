class SongsController < ApplicationController
  RESULTS_PER_PAGE = 20

  def create
    @song = Song.new(song_params)
    if @song.save
      ProgramsHelper.save_song_to_playlist!(song_id: @song.id, program_number: params[:song][:program_number])
      redirect_to @song
    else
      render 'new'
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    if @song.update(song_params)
      redirect_to @song
    else
      render 'edit'
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path
  end

  def show
    @song = Song.find(params[:id])
  end

  def index
    @songs = Song.paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist, :album, :year)
  end
end