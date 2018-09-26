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

# Show who the artist is for an albums

#update artist

# update album

# find artist and albums by id
