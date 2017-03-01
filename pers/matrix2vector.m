function a = matrix2vector(A)
% stack columns of matrix one on top of another into a vector 

Nrow = size(A,1);
Ncol = size(A,1);

a = [];

for i=1:Ncol
    a = [ a ; A(:,i)];
end
