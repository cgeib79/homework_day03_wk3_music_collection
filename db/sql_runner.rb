require('pg')

class SqlRunner

  def self.run(sql, values = []) # means: if only 1 thing passed in, set to empty array, otherwise whatever is passed in

    begin
      db = PG.connect({dbname: "music_collection", host: "localhost"})
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
