require("pg")
require_relative('../db/sql_runner.rb')

class Album
  attr_reader :id, :album_name, :genre

  def initialize(options)
    @id = options['id'].to_i() if options ['id']
    @album_name = options['album_name']
    @genre = options['genre']
  end

  def save()
    sql = "INSERT INTO albums (album_name, genre)
    VALUES ($1, $2) RETURNING id"
    values = [@album_name, @genre]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def Album()
    db = PG.connect({dbname: "music_collection", host: "localhost"})
    sql = 'SELECT * FROM albums'
    db.prepare("all", sql)
    orders = db.exec_prepared("all")
    return orders.map {|album| Album.new(album)}
  end

  def self.all()
    sql = "SELECT * FROM albums"
    orders = SQLRunner.run(sql)
    return orders.map{|album| Album.new(album)}
  end

  def artist()
    db = PG.connect({dbname: "music_collection", host: "localhost"})
    sql = "SELECT * FROM artists WHERE id = $1"
    values =  [@artist_id]
    SqlRunner.run(sql, values)
    return Artist.new(results[0])
  end

  def delete()
    db = PG.connect({dbname: "music_collection", host: "localhost"})
    sql = 'DELETE FROM albums'
    SqlRunner.run(sql)
    values = [@id]
  end

  def Album.delete_all()
    db = PG.connect({dbname: "music_collection", host: "localhost"})
    sql = 'DELETE FROM albums'
    SqlRunner.run(sql)
  end

  def update()
    db = PG.connect({dbname: "music_collection", host: "localhost"})
    sql = "UPDATE albums SET (album_name, artist_id, genre) =($1, $2, $3) WHERE id = $4"

    values = [@album_name, @genre, @id]
    SQLRunner.run(sql, values)
  end

end
