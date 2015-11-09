%%Input_datas: matrix with all features.
%%input_fixed_indexes: indexes of inputs that are fixed.
%%features_names: names of the features.
%%target: target vector.
%%n_training: # of training.
%%n_hidden_neurons: #hidden neurons.

%%This function has this following purpose: it trains n_training times with n_hidden_neurons the neural network.
%%The feature are specified in the input_fixed_indexes and iteratively add
%%one at time one feature taken from input_datas
%%This function returns the performance matrix, in which by column are
%%present the MSEs of each training. The righest column has the mean MSE
%%The performance matrix by row contains the MSE of each different
%%combination of features.

%%Example: performance(1,2) contains the MSE of 2nd training the 1st combination of
%%features. 

function [ performance ] = NN_test_for_generic_input( input_datas, input_fixed_indexes, features_names, target , n_training,n_hidden_neurons)

%%clock is present in order to know how much time the total trainings
%%require. One timestamp is at the start of the function and another one at
%%the end of this function
c = clock 
fixed_input=zeros(size(input_fixed_indexes,1),(size(input_datas,2)));
fprintf('# hidden neurons:%d\n ',n_hidden_neurons);
per_rows=size(input_datas,1)-size(input_fixed_indexes,1);
performance=zeros(per_rows, n_training+1);

for i=1:size(input_fixed_indexes,1)%Put the input(s) relative to fixed index(es) in the fixed_input matrix
fixed_input(i,:)=input_datas(input_fixed_indexes(i,1),:);
end
k=1;
for i=1:1:size(input_datas,1)%
     is_already_an_input=0;
     
        for j=1:size(input_fixed_indexes,1)
            if i==input_fixed_indexes(j,1)%%If the fixed feature index is already present, do not train the neural network
            is_already_an_input=1;
            fprintf('The feature %d (%s) is already present in the fixed feature\n',input_fixed_indexes(j,1), features_names{input_fixed_indexes(j,1)});
            break;
            end
        end
        
        if(is_already_an_input==0)
            input=[fixed_input;input_datas(i,:)];
            fprintf('The input(s) ');
         
            for j=1:size(input_fixed_indexes,1)
                fprintf('%s ',features_names{ input_fixed_indexes(j,1)});
            end
            
            fprintf('and %s are tested in the NN. The MSE is\n',features_names{i});
            
            for j=1:n_training
            performance(k,j)=NN_training_single_feature(input, target,n_hidden_neurons); 
            fprintf('%d (tr #%d)\n',performance(k,j),j);
            end  
             performance(k,n_training+1)=mean(performance(k,1:n_training));
             fprintf('The mean of above MSE(s) is %d\n', performance(k,n_training+1));
              k=k+1;
        end
end
c = clock
end

