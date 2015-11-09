function [ MSE ] = compute_MSE_fuzzy( input_vectors, FIS_file, target_vector )

Y=evalfis(input_vectors, FIS_file);
Y=Y';
err=Y-target_vector;
SE=err.^2;
MSE=sum(SE)/size(input_vectors, 2);

end

