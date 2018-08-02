require "pry"
require_relative("../models/artist")
require_relative("../models/album")

artist1 = Artist.new(
  {
    'artist_name' => "Prince"
  }
)

artist1.save()

artist2 = Artist.new(
  {
    'artist_name' => "Michael Jackson"
  }
)

artist2.save()

album1 = Album.new(
  {
    'album_name' => "Purple Rain"
  }
)

album1.save()

album2 = Album.new(
  {
    'album_name' => "Thriller"
  }
)

album2.save()

binding.pry
nil
