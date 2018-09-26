require_relative('models/artist.rb')
require_relative('models/album.rb')
require('pry')

# Delete all table contents
Album.delete_all()
Artist.delete_all()


artist1 = Artist.new({
  'name' => 'BigDubz'
})

artist2 = Artist.new({
  'name' => 'Exploding Rats'
})

artist3 = Artist.new({
  'name' => 'Manfrotto'
})

artist1.save()
artist2.save()
artist3.save()

album1 = Album.new({
  'title' => 'Fruit Loops',
  'genre' => 'reggae',
  'artist_id' => artist1.id
})

album2 = Album.new({
  'title' => 'Barry Sidebottom and his enormous band',
  'genre' => 'funk',
  'artist_id' => artist2.id
})

album3 = Album.new({
  'title' => 'Origin of Sausage',
  'genre' => 'electro-swing',
  'artist_id' => artist2.id
})
# binding.pry

album1.save()
album2.save()
album3.save()

# list all albums
albums = Album.list()
albums.each do |album|
  p "#{album.title} by #{Artist.find(album.artist_id)} (#{album.genre})"
end

# List all artists
Artist.list().each do |artist|
  p artist.name
end
# List all albums by a specific artist
output = Album.list_album(artist2.id)
p "#{artist2.name} has released: "
output.each do |album|
  p album.title
end
# Show who the artist is for an albums
output = Artist.show_artist(album1.artist_id)
p "#{album1.title} was made by #{output}"
#update artist
p "New Artist Name: Jeff"
new_name = "Jeff"
artist1.update(new_name)
p Artist.show_artist(artist3.id)

# update album
p "New Album Genre: Scat"
new_name = "Scat"
album2.update(new_name)
p Album.show_album_genre(album2.id)

# find artist and albums by id
p Artist.show_artist(artist2.id)
p Album.show_album_title(album3.id)
