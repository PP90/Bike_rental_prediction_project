%%This function has the purpose to train the neueal network n_training
%%times.
%%It returns the MSE for each training and their mean. The mean is the
%%righest column.

function [ performance ] = NN_train_single_feature_n_times( feature, target, n_training,n_hidden_neurons )
 performance=zeros(1,n_training+1);
 fprintf('#hidden neurons:%d\n',n_hidden_neurons);
 for i=1:n_training
     performance(1,i)=NN_training_single_feature(feature,target,n_hidden_neurons);
 end
  performance(1,n_training+1)=mean(performance(1,1:n_training));
  disp(performance);
end

