function location = findMaximal(result,th)

      hLocalMax = vision.LocalMaximaFinder;
      hLocalMax.MaximumNumLocalMaxima = 40;
      hLocalMax.NeighborhoodSize = [15 15];
      hLocalMax.Threshold = th;
      location = step(hLocalMax,result);
  
end

   

 