% The code of NSGA-II accomplished on MATLAB

clc;format compact;tic;

%-----------------------------------------------------------------------------------------   
    % Problem Selection and Problem Paramaters
 for Problem = 1:7
    
  for M = 4 : 2 : 10  % number of objectives
    
    if Problem == 1 % DTLZ1
         
      K = 5;  % the parameter in DTLZ1
              
    elseif Problem == 2 || 3 || 4  
          
      K = 10;  % the parameter in DTLZ2, DTLZ3, DTLZ4,
                
    elseif Problem == 5 || 6 
          
      K = 10;  % the parameter in DTLZ5, DTLZ6  
           
    elseif Problem == 7 % DTLZ7
     
      K = 20;  % the parameter in DTLZ7
            
    end 
    D = M + K - 1;
    
    MinValue   = zeros(1,D);
    MaxValue   = ones(1,D);
    Boundary = [MaxValue;MinValue];  
%-----------------------------------------------------------------------------------------   
    % Algorithm parameters
    
       
    if Problem == 1
        
     Generations = 700;	 % number of iterations
     
    elseif Problem == 3
        
     Generations = 1000;
     
    else
        
      Generations = 250;
      
    end
   
    if M == 2 
        
      N = 100;            % population size
      
    elseif M == 4
        
      N = 120;
    
    elseif M == 6
        
      N = 132;
      
    elseif M == 8
        
      N = 156;
      
    elseif M == 10
        
      N = 276;
      
    end
       
   Runs = 30;
   
   kappa = 0.05;
%-----------------------------------------------------------------------------------------      
  for run = 1 : Runs
         
    % initialize the population
    Population                          = repmat(MinValue,N,1) + repmat(MaxValue - MinValue,N,1).*rand(N,D); % initial population
    FunctionValue                       = F_DTLZ(Population,Problem,M,K);                      % calculate the objective function values
  
%-----------------------------------------------------------------------------------------      
    % start iterations
    for Gene = 1 : Generations
        MatingPool                 = TournamentSelection(2,N,-CalFitness(FunctionValue,kappa));
        Offspring                  = F_operator(Population(MatingPool',:),Boundary);
        NewFunctionValue           = F_DTLZ(Offspring,Problem,M,K);
        [Population,FunctionValue] = EnvironmentalSelection([Population;Offspring],[FunctionValue;NewFunctionValue],N,kappa);    
        
       Gene         
    end

    F_output(Population,toc,'IBEA-DTLZ',Problem,M,K,run);
    
  end
     
  end
  
 end
