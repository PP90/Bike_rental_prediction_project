%%This function has the purpose to train the neural network with RBF. 
%%In input there are:
%%feature: feature vector, in which the 70% (deafult) is selected for the training and (30%) for the test
%%target: the target vector

function [ MSE ] = NN_RBF_train( features, target, goal, max_neurons, DF, spread)

[tr_idx,test_idx]=dividerand(size(target,1),0.7,0.3);
tr_subset=features(tr_idx,:);
tr_tgt_subset=target(tr_idx,:);

test_subset=features(test_idx,:);
test_tgt_subset=target(test_idx,:);

%%Train the network
    net=newrb(tr_subset',tr_tgt_subset', goal, spread, max_neurons, DF);%%I build the NN with the training feature subsa,ple and training target sunsample
    outputs=sim(net,test_subset');%%I use the test feature subsample to get the output
    MSE=perform(net,test_tgt_subset', outputs);
%disp(MSE);
end

