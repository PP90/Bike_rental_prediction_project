% This script was generated after a neural network training. Then was
% modified in way that the user can specify also the number of hidden neurons.
%%For more details see help train


function [  performance ] = NN_train_single_feature( inputs, targets, n_hidden_neurons  )

% Create a Fitting Network
net = fitnet(n_hidden_neurons);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;


% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
%errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);
%celldisp(name_input,'input');
%fprintf(' has the MSE equal to %f. \n', performance);
% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, plotfit(net,inputs,targets)
%figure, plotregression(targets,outputs)
%figure, ploterrhist(errors)
