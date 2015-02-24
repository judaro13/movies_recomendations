namespace :tests do
  task load: :environment do
    puts 'begin'
    max = 34760
    
    (1..9).each do |i|
      puts i
      puts "*"*10
      file_path = "/home/juliana/Uniandes/project/movies_recomendations/db/#{i}0-raitings.csv"

      n = File.open("/home/juliana/Uniandes/project/movies_recomendations/db/#{i}0-test-raitings.txt", 'w+')
      n.write("training test dataset #{i}0%\n")
      
            n.write("similarity,recommender,neighborhood_size,data_set_load,evaluation_time,evaluation_result,evaluation_set,recomendations_time")
      [ "GenericUserBasedRecommender","GenericItemBasedRecommender"].each do |recomender|
        [ "PearsonCorrelationSimilarity","TanimotoCoefficientSimilarity", "UncenteredCosineSimilarity"].each do |similarity|
          [5,10,20,40,60,80,100,200,300].each do |size|
            values = {:similarity => similarity, :recommender => recomender, :neighborhood_size => size.to_i}
            var = [similarity,recomender,size.to_i]
            t=Time.now
            recomendator = JrubyMahout::Recommender.new(values) 
            recomendator.data_model = JrubyMahout::DataModel.new('file', { :file_path => file_path  }).data_model
            t2=Time.now
            var << t2-t
            
            t=Time.now
            r = recomendator.evaluate("0.#{i}".to_f, "0.#{10-i}".to_f)
            t2=Time.now
            
            var << t2-t
            var << r
            var << "0.#{i} - 0.#{10-i}"
              
            t=Time.now
            recomendator.recommend(2, 10, nil)
            t2=Time.now
            var << t2-t
            
            n.write("#{var}\n")
            puts "*"
          end
        end
      end  
      
      n.close
    end
    
    puts 'done'
  end
end
