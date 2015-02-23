namespace :ratings do
  desc "TODO"
  task load: :environment do
    puts 'begin'
    f = File.open("/home/juliana/Uniandes/project/movies_recomendations/db/raings.csv", 'r+')
    n = File.open("/home/juliana/Uniandes/project/movies_recomendations/db/raitings.csv", 'w+')
    count = 1
    f.each_line do |line|
      l = line.chomp.split('::')
      n.write("#{l[1].to_i},#{l[3].to_i},#{l[2]}\n")
      count = count + 1
      print '.'
    end
    f.close
    n.close
    puts 'done'
  end
end
