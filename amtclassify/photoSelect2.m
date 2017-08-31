%% photo select2
% run amtErrorRateBar.m first
clc
sigmod = @(x) 1 ./ (1 + exp(-x));
score = sigmod(ps3);
for i = 1:numel(score)
    fprintf('%s %f %f\n',picName{i},score(i),sigmod(gtScore(i)-3.5));
end

% fprintf('===================\n');
% 
% for i = 1:numel(scr)
%     fprintf('%s %f\n',scr{i}.fname,sigmod(scr{i}.fs - 2.5));
% end
