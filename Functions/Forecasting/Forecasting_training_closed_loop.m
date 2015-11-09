function [ predicting_vector ] = Forecasting_training_closed_loop(net, all_output_2012, day, features, delays, farest_prevision )

MSE=zeros(farest_prevision,1);
input_features=features(day-delays:day+farest_prevision,:);
actual_output=all_output_2012(day-delays:day+farest_prevision,:);

target_vector=actual_output;
target_vector(delays+2:end,:)=NaN;

%%Closed network part
INPUT_closed = tonndata(input_features,false,false);
OUTPUT_closed = tonndata(target_vector,false,false);
netc = closeloop(net);
netc.name = [net.name ' - Closed Loop'];
%view(netc)
[xc,xi_c,ai_c,t_c] = preparets(netc,INPUT_closed,{},OUTPUT_closed);

[outputForecastC,xf,af] = netc(xc,xi_c,ai_c);
comparing=num2cell(actual_output');
predicting_vector=cell2mat(outputForecastC);
for i=1:farest_prevision
 %   MSE(i,1)=mse(netc,outputForecastC(1,i), comparing(1,i));
end
end

