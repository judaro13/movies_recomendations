namespace :movies do
  task load: :environment do
    puts 'begin'
    f = File.open("/home/juliana/Uniandes/project/movies_recomendations/db/import-movies.csv", 'r+')
    f.each_line do |line|
      l = line.split(',')
       Movie.create(id: l[0], name: l[1], image_url: l[2], genders: l[3].chomp)
      print '.'
    end
    f.close
    puts 'done'
  end
end
