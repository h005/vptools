%% this function was built to make a classify

% method is a cell array contains 2 values
% method{1} is 'classifyEach' or 'calssifyCombine'
% for 'classifyEach'
% method{2} can be one of {'2D', '3D'}
% for 'calssifyCombine'
% method{2} can be one of {'2D combine','3D combine','2D3D combine'}

function [gt,pl,ps,ln,scl] = generalClassify(fs,rate,fname,method)
if numel(method) == 1
    disp('general classify paramenter error');
    return;
else
    if strcmp(method{1},'generalClassifyEach')
        if strcmp(method{2},'2D')
            feaName = loadFeaName('/home/h005/Documents/vpDataSet/kxm/vpFea/kxm.2dfname');
            [gt, ps, ln, scl] = classifyEach(fs,feaName,rate,fname,method{3});
            % it is necessary to modify classifyEach to get predict label.
            pl = [];

        elseif strcmp(method{2},'3D')
            feaName = loadFeaName('/home/h005/Documents/vpDataSet/kxm/vpFea/kxm.3dfname');
            [gt, ps, ln, scl] = classifyEach(fs,feaName,rate,fname,method{3});
            pl = [];

        end
    elseif strcmp(method{1},'generalClassifyCombine')
        if strcmp(method{2},'2D combine')
            [gt, pl, ps, scl]...
                = classifyCombine(fs,rate,fname,method{3});
            ln = {'2D combine'};
        elseif strcmp(method{2},'3D combine')
            [gt, pl, ps, scl]...
                = classifyCombine(fs,rate,fname,method{3});
            ln = {'3D combine'};
        elseif strcmp(method{2},'2D3D combine')
            [gt, pl, ps, scl]...
                = classifyCombine(fs,rate,fname,method{3});
            ln = {'2D3D combine'};
        end
    elseif strcmp(method{1},'generalGMMClassifyCombine')
        if strcmp(method{2},'2D combine')
            disp('2D combine')
%             if strcmp(method{3},'ens classify')
%                 disp('debug')
%             end
            [gt,pl,ps,scl] ...
                = gmmClassifyCombine(fs,rate,fname,method{3});
            ln = {'2D combine'};
        elseif strcmp(method{2},'3D combine')
            disp('3D combine')
            [gt,pl,ps,scl] ...
                = gmmClassifyCombine(fs,rate,fname,method{3});
            ln = {'3D combine'};
        elseif strcmp(method{2},'2D3D combine')
            disp('2D3D combine')
            [gt,pl,ps,scl] ...
                = gmmClassifyCombine(fs,rate,fname,method{3});
            ln = {'2D3D combine'};
        end
    elseif strcmp(method{1},'svm2kClassifyCombine')
        if ~strcmp(method{2},'2D3D combine')
            disp('general calssify paramenter error');
            return;
        else
            [gt, pl, ps, scl]...
                = svm2kClassify();
            ln = {'2D3D combine'};
        end
    elseif strcmp(method{1},'FVclassifyCombine')
        if strcmp(method{2},'2D combine')
            [gt, pl, ps, scl]...
                = classifyCombineFV(fs,rate,fname,method{3});
            ln = {'2D combine'};
        elseif strcmp(method{2},'3D combine')
            [gt, pl, ps, scl]...
                = classifyCombine(fs,rate,fname,method{3});
            ln = {'3D combine'};
        elseif strcmp(method{2},'2D3D combine')
            [gt, pl, ps, scl]...
                = classifyCombineFV2d3d(fs,rate,fname,method{3});
            ln = {'2D3D combine'};
        end
    else
        disp('general calssify paramenter error');
        return;
    end
end
