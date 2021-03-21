module ArtistsHelper
  def display_artist(song)
    song.artist.nil? ? link_to("Add Artist", edit_song_path(song)) : link_to(song.artist_name, artist_path(song.artist))
  end

  # def artist_select(song, path)
  #   select_tag "something", options_from_collecion_for_select(Artist.all, :id, :name)
  # else
  #   hidden_field_tag "something", 
  # end

  # def author_id_field(post)
  #   if post.author.nil?
  #     select_tag "post[author_id]", options_from_collection_for_select(Author.all, :id, :name)
  #   else
  #     hidden_field_tag "post[author_id]", post.author_id
  #   end
  # end
end
