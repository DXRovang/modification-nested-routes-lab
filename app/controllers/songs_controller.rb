class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    if params[:artist_id]
      artist = Artist.find_by(id: params[:artist_id])
      if artist != nil
        @song = Song.new(artist_id: params[:artist_id])
      else
        redirect_to artists_path
      end
    else
      @song = Song.new
    end
   
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
  # binding.pry
    # @path = artist_songs_path(@artist)

    if params[:artist_id] #if user sends an artist id
      @artist = Artist.find_by(id: params[:artist_id])

      if @artist.nil? #if the artist id bad, go to artists index
        redirect_to artists_path

      else #if the artist id is good, set song var & go to artist songs index
        @song = @artist.songs.find_by(artist_id: params[:artist_id])
        redirect_to artist_songs_path(@artist)
      end

    else #if the user does not send an artist id, set song var & go to regular edit
      @song = Song.find_by(id: params[:id])
    end
  end

  def update
    # binding.pry
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end

