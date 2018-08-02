require("pg")
require_relative('../db/sql_runner.rb')

class Artist
  attr_reader :id, :artist_name


  def initialize(options)
    @id = options['id'].to_i() if options ['id']
    @artist_name = options ['artist_name']
  end

  def save()
    sql = "INSERT INTO artists (artist_name)
    VALUES ($1) RETURNING id"
    values = [@artist_name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def self.delete_all()
    db = PG.connect({dbname: "music_collection", host: "localhost"})
    sql = "DELETE FROM ARTISTS"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    orders = SqlRunner.run(sql)
    return artists.map {|order| Artists.new(order)}
  end

end
