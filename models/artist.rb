require('pg')
require('pry')
require_relative('../db/sql_runner.rb')

class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "
    INSERT INTO artists
    (name) VALUES ($1)
    RETURNING id;"

    result = SqlRunner.run(sql,[@name])
    @id = result[0]['id'].to_i
    # binding.pry
    # nil
  end

  def self.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def self.list()
    sql = 'SELECT * FROM artists;'
    artist_hashes = SqlRunner.run(sql)
    artist_objects = artist_hashes.map do |artist|
      Artist.new(artist)
    end
    return artist_objects
  end

  def self.show_artist(id)
    sql = 'SELECT name FROM artists WHERE id = $1;'
    result = SqlRunner.run(sql,[id])
    # binding.pry
    return result[0]['name']
  end

  def self.find(id)
    sql = 'SELECT name FROM artists WHERE id = $1;'
    results = SqlRunner.run(sql,[id])
    artist = results[0]['name']
    # artist = Artist.new(artist_hash)
    # binding.pry
    return artist
  end

  def self.find_one(input_id)
    sql = "SELECT name FROM artists WHERE id = $1;"
    result = SqlRunner.run(sql,[input_id])
    return result[0]['name']
  end

  def update(name)
    sql='
      UPDATE artists
      SET name = $1
      WHERE id = $2
    ;'
    # binding.pry
    SqlRunner.run(sql,[name,@id])
  end
end
