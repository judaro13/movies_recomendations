module UsersHelper
  
  def model_recomend_array
    [[ "Users", "GenericUserBasedRecommender" ],["Items","GenericItemBasedRecommender"]]
  end
  
  def model_recomend_array_selected
    result =[ "Users", "GenericUserBasedRecommender" ]
    if rc = params[:recommender]
      if rc !=  "GenericUserBasedRecommender"
        result =["Items","GenericItemBasedRecommender"]
      end
    end
    result 
  end
  
  def similarity_array
    [[ "Pearson Correlation", "PearsonCorrelationSimilarity" ],
     [ "Jaccard Coefficient", "TanimotoCoefficientSimilarity" ],
     ["Cosine Similarity", "UncenteredCosineSimilarity"]]
  end
  
  def similarity_array_selected
    result = [ "Pearson Correlation", "PearsonCorrelationSimilarity" ]
    if rc = params[:similarity]
      if rc == "TanimotoCoefficientSimilarity"
        result = [ "Jaccard Coefficient", "TanimotoCoefficientSimilarity" ]
      elsif rc == "UncenteredCosineSimilarity"
        result = ["Cosine Similarity", "UncenteredCosineSimilarity"]
      end
    end
    result
  end
  
  def neighborhood_array
    [[5,5],[10,10],[20,20],[30,30],[40,40],[50,50],[60,60],[70,70],[80,80],[90,90],[100,100],[200,200],[300,300]]
  end
  def neighborhood_array_selected
    result = [ 5,5]
    if n = params[:size]
      result =[n,n]
    end
    result 
  end
end
