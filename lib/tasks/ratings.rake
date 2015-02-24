namespace :ratings do
#   desc "TODO"
#   task load: :environment do
#     puts 'begin'
#     f = File.open("/home/juliana/Uniandes/project/movies_recomendations/db/loaded-raitings.csv", 'r+')
#     f.each_line do |line|
#       l = line.chomp.split(',')
#       Rating.create(user_id: l[0], movie_id: l[1], value: l[2], predict: false)
#       print '.'
#     end
#     f.close
#     
#     n = File.open("/home/juliana/Uniandes/project/movies_recomendations/db/unloaded-raitings.csv", 'r+')
#     n.each_line do |line|
#       l = line.chomp.split(',')
#       Rating.create(user_id: l[0], movie_id: l[1], value: l[2], predict: true)
#       print '.'
#     end
#     n.close
#     puts 'done'
#   end
#   
  task load: :environment do
    puts 'begin'
    max = 34760
    
    (1..9).each do |i|
      puts i
      puts "*"*10
      f = File.open("/home/juliana/Uniandes/project/movies_recomendations/db/ratings.dat", 'r+')
      n = File.open("/home/juliana/Uniandes/project/movies_recomendations/db/#{i}0-raitings.csv", 'w+')
        
      count = 0
      f.each_line do |line|
        break if count >= max*i
        l = line.chomp.split('::')
        n.write("#{l[0].to_i},#{l[1].to_i},#{l[2]}\n")
        count = count + 1
        print '.'
      end
      f.close
      n.close
    end
    puts 'done'
  end
end
