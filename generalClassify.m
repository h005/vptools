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
            feaName = loadFeaName('/home/h005/Documents/vpDataSet/tools/vpData/kxm/vpFea/kxm.2dvnfname');
            [gt, pl, ps, ln, scl] = classifyEach(fs,feaName,rate,fname,method{3});
            % it is necessary to modify classifyEach to get predict label.
%             pl = [];

        elseif strcmp(method{2},'3D')
            feaName = loadFeaName('/home/h005/Documents/vpDataSet/tools/vpData/kxm/vpFea/kxm.3dfname');
            [gt, pl, ps, ln, scl] = classifyEach(fs,feaName,rate,fname,method{3});
%             pl = [];

        end
    elseif strcmp(method{1},'featureSelection')
        if strcmp(method{2},'2D')
            feaName = loadFeaName('/home/h005/Documents/vpDataSet/tools/vpData/kxm/vpFea/kxm.2dvnfname');
            combineN = method{4};
            cfeaName = combiner(feaName,combineN);
            [gt, pl, ps, ln, scl] = classifyEach(fs,cfeaName,rate,fname,method{3});
            % it is necessary to modify classifyEach to get predict label.
            % pl = [];
            
        elseif strcmp(method{2},'3D')
            feaName = loadFeaName('/home/h005/Documents/vpDataSet/tools/vpData/kxm/vpFea/kxm.3dfname');
            combineN = method{4};
            cfeaName = combiner(feaName,combineN);
            [gt, pl, ps, ln, scl] = classifyEach(fs,cfeaName,rate,fname,method{3});
            %  pl = [];
            
        end
            
    elseif strcmp(method{1},'comparisonClassifyCombine')
        if strcmp(method{2},'2D3D combine')
%             if strcmp('svm2k',method{3})
%                 [gt, pl, ps, scl]...
%                     = svm2kClassifyComparisonValidation
%             else
            [gt, pl, ps, scl]...
                = comparisonClassifyCombine(fs,rate,fname,method{3},method{4});
            ln = method{4};
%             end
        else
            disp('parameter error for comparisonClassifyCombine')
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

end

%% this function generate the combination of feaName
% choose num elements from feaName
% such as [1,2,3] num = 2
% return [1,2],[1,3],[2,3]
% warning this function need num >= 2
function vec = combiner(feaName,num)
    tmp = 1:numel(feaName);
    vecIndex = nchoosek(tmp,num);
    vec = cell(1,size(vecIndex,1));
    for i=1:numel(vec)
        vec{i}.name = feaName{vecIndex(i,1)}.name;
        vec{i}.ind = feaName{vecIndex(i,1)}.ind;
        for j=2:size(vecIndex,2)
            vec{i}.name = [vec{i}.name '_' feaName{vecIndex(i,j)}.name];
            vec{i}.ind = [vec{i}.ind feaName{vecIndex(i,j)}.ind];
        end
    end
end

