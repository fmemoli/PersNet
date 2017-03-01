% Copyright (c) 2017, Samir Chowdhury and Facundo Memoli. The Ohio State University. All rights reserved. 
%Redistribution and use in source and binary forms, with or without modification, are permitted provided that the 
%following conditions are met: 
%• Redistributions of source code must retain the above copyright notice, this list of
% conditions and the following disclaimer. 
%• Redistributions in binary form must reproduce the above copyright notice, 
% this list of conditions and the followingdisclaimer in the documentation and/or other materials provided with the distribution. 
%• Neither the name of the {organization} nor the names of its contributors may be used to endorse or promote products derived 
% from this software without specific prior writtenpermission. 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
% INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
% STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
% EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function [R obj] = bap(C)

[nx ny] = size(C);

cmin = min(C(:));
cmax = max(C(:));
if cmin==cmax
    R = ones(nx,ny);
    obj = cmax;
else
    
    cs = sort(unique(C(:)));
    
    FLAG = 1;
    imin = 1;
    imax = length(cs);
    rg = 1:length(cs);
    
    while length(rg)
        %C>V
        idx = ceil(median(rg));
        V = cs(idx);
        R = (C<=V);
       
        FLAG = (prod(sum(R)>0)*prod(sum(R')>0));
        if FLAG
            imax = idx;
        else
            imin = idx;
        end
        rg = [imin+1:imax-1];
    end
    
    R = (C<=cs(imin));
    FLAG = (prod(sum(R)>0)*prod(sum(R')>0));
    if FLAG
        imax = imin;
    end
    
    obj = cs(imax);
    R = C<=obj;
end
%p  dmperm(C<=obj);