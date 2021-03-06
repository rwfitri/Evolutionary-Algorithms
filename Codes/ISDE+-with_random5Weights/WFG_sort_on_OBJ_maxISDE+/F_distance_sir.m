function DistanceValue = F_distance(FunctionValue,M)
% Function <F_distance> calculates the crowding-distance of the solutions
% in each front
% Copyright 2014 BCMA Group in Anhui University
% Written by Ye Tian

    [N,M] = size(FunctionValue);
    PopObj = FunctionValue;
%%  sumof OBJECTIVE
 
    fmax   = repmat(max(PopObj,[],1),N,1);
    fmin   = repmat(min(PopObj,[],1),N,1);
    PopObj = (PopObj-fmin)./(fmax-fmin);
    %fpr     = mean(PopObj,2);
    %[~,rank] = sort(fpr);
    % assigning Rank for SOB and after sorting on each objective i.e. N*M+1 % rank matrix
    rank          = zeros(N,M+1);
    fpr           = mean(PopObj,2);
    
    XX = [PopObj,fpr];
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %DistanceValue = zeros(1,N); 
   
   % isde=zeros(1,N);% for mean ISDE
  isde=[];% for max ISDE
%% org ISDE+ calculation
for R = 1 : M+1
    DistanceValue = zeros(1,N); 
    [~,rank] = sort(XX(:,R));
    for j = 2 : N
        
        SFunctionValue = max(PopObj(rank(1:j-1),:),repmat(PopObj(rank(j),:),(j-1),1));
        
        Distance = inf(1,j-1);
        
        for i = 1 : (j-1)
            Distance(i) = norm(SFunctionValue(i,:)-PopObj(rank(j),:))/M;
        end
        
        Distance = min(Distance);
        DistanceValue(rank(j)) = exp(-Distance);
      
    end
     %isde= isde+DistanceValue;  % sum of all values
    isde= [isde;DistanceValue];
end

%DistanceValue = isde./(M+1);% mean Value of ISDE
  DistanceValue = max(isde,[],1); % obtaining Max ISDE in all 
 
    