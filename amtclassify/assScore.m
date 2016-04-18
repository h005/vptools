%% assign score
% method = 
% ave, get average score
% mode, get mode score

function scr = assScore(sc,method)
scr = cell(size(sc));
switch (method)
    case 'ave'
        for i=1:length(sc)
            scr{i}.fname = sc{i}.fname;
            scr{i}.fs = mean(sc{i}.fs);
        end
    case 'mode'
        for i=1:length(sc)
            scr{i}.fname = sc{i}.fname;
            scr{i}.fs = mode(sc{i}.fs);
        end
end