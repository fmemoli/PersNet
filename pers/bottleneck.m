function [i_ass,j_ass,c_star] = bottleneck(C);
% this function finds the indeces (i_ass,j_ass) of the bottleneck assigment entry
% in the square matrix C
% c_star is the minimum cost of the bottleneck assignment problem
% for details see "Linear assignment problems and Extensions" by R.E. Burkard and E. Cela (1998)

% Copyright by Luca Schenato and UC Berkeley, 20 April 2004
n = size(C,1);  % matrix size

% If C is empty, return dist=0 (Samir: added this 9.26.2016)
if (n==0)
    i_ass=[];
    j_ass=[];
    c_star=0;

else % Do everything else
    
if n==1     % this handle the trivial case of 1x1 matrix
    i_ass = 1;
    j_ass = 1;
    c_star=C;%Samir: added this line
    return;
end

N_trials = 3; %number of trials for the perfect matching existance test
c = matrix2vector(C); % unfold the matrix cost into a vector
N = n^2; 

[c_sorted,index_sort] = sort(c);  % sorts the cost elements and the permutation index list

% initialize search of c_star 
index_unfeasible = 1;
index_feasible = N;   % assume this is true

%%%% search for c_star doing bisection on the sorted cost vector c_sorted

while (index_unfeasible+1~=index_feasible)
    index_test = floor((index_feasible+index_unfeasible)/2);  % index to be tested
    k = 1;
    d = 0;
    while (d==0 & k <=N_trials)
        C_tresh = (C<=c_sorted(index_test));   % this finds the edges to be checked for existance of 
                                               % perfect matching
        C_tresh_rand = rand(n,n).*C_tresh;     % random assigment of edges, see Tutte Theorem  
        C_Tutte = [ zeros(n,n) C_tresh_rand ; -C_tresh_rand' zeros(n,n)]; % Tutte matrix
        d = det(C_Tutte);   
        if d~=0     % if d differnent from 0 then surely feasible
            index_feasible = index_test;
        end
        k = k+1;
    end
    if index_feasible ~= index_test  % if N_trials unsuccessful to find feasibility 
                                     % then we set it to unfeasible. this is true with high
                                     % probability
        index_unfeasible = index_test;
    end
end

ind_ass = index_sort(index_feasible);  % find index of feasible cost in the vector c
j_ass = floor((ind_ass-1)/n)+1;        % find index of feasible cost in the matrix C
i_ass = mod(ind_ass-1,n)+1;
c_star = C(i_ass,j_ass);               % minimum bottleneck assigment cost
end
end
%list_assigment(i_ass)=j_ass;


