namespace :movies do
  task load: :environment do
    puts 'begin'
    f = File.open("/tmp/movies.dat", 'r+')
    f.each_line do |line|
      l = line.split('::')
      Movie.create(imdb_id: l.first, name: l.second, genders: l.third.chomp.split('|'))
      print '.'
    end
    f.close
    puts 'done'
  end
  
  task update: :environment do
    puts 'begin'
    Movie.all.each do |m|
      next if m.image_url != 'http://bit.ly/1Bji90q'
      mm = Imdb::Movie.new(m.imdb_id)
      m.set(image_url:  mm.poster) if mm.poster
      print '.'
    end
    puts 'done'
  end
end
