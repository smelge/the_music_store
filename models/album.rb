require('pg')
require('pry')
require_relative('../db/sql_runner.rb')

class Album
  attr_accessor :title,:genre
  attr_reader :id,:artist_id

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "
    INSERT INTO albums
    (title,genre,artist_id)
    VALUES
    ($1,$2,$3)
    RETURNING id;"

    values = [@title,@genre,@artist_id]
    result = SqlRunner.run(sql,values)
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def self.list()
    sql = 'SELECT * FROM albums;'
    result = SqlRunner.run(sql)

    return result.map {|album| Album.new(album)}
  end

  def self.list_album(id)
    sql = '
      SELECT title FROM albums WHERE artist_id = $1;
    '
    results = SqlRunner.run(sql,[id])
    albums = results.map do |album_hash|
      Album.new(album_hash)
    end
    return albums
  end

  def self.show_album_genre(id)
    sql = 'SELECT genre FROM albums WHERE id = $1;'
    result = SqlRunner.run(sql,[id])
    # binding.pry
    return result[0]['genre']
  end

  def self.show_album_title(id)
    sql = 'SELECT title FROM albums WHERE id = $1;'
    result = SqlRunner.run(sql,[id])
    # binding.pry
    return result[0]['title']
  end

  def update(name)
    sql='
      UPDATE albums
      SET genre = $1
      WHERE id = $2
    ;'
    # binding.pry
    SqlRunner.run(sql,[name,@id])
  end


end
