%% demoLocSpecFor
% Script to run local spec matching on sample of Fortunato database

% Copyright (c) 2017, Samir Chowdhury and Facundo Memoli. The Ohio State University. All rights reserved. 
%Redistribution and use in source and binary forms, with or without modification, are permitted provided that the 
%following conditions are met: 
%â€¢ Redistributions of source code must retain the above copyright notice, this list of
% conditions and the following disclaimer. 
%â€¢ Redistributions in binary form must reproduce the above copyright notice, 
% this list of conditions and the followingdisclaimer in the documentation and/or other materials provided with the distribution. 
%â€¢ Neither the name of the {organization} nor the names of its contributors may be used to endorse or promote products derived 
% from this software without specific prior writtenpermission. 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
% INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
% STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
% EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

mainfolder=pwd;
workfolder=[pwd,'/fortunato/'];
res_folder = [workfolder,'/res_loc_spec/'];

cd(mainfolder)
mkdir(res_folder)
cd(workfolder)
dire = dir('d*.mat');
%%%%%%%%

Nshapes = length(dire);

p=nchoosek(1:Nshapes,2);

addpath(mainfolder)

for i=1:length(p)
%for i=1:length(p)
   x=p(i,1);
   y=p(i,2);

    ni = sprintf('res_%d_%d.mat',x,y);
    fi = [res_folder '/' ni];%change slash depending on local/terminal    

  if ~exist(fi)

   a=load(dire(x).name);
   b=load(dire(y).name);

   sX = a.var;
   sY = b.var;

   [~,c]=matchLocSpec(sX,sY);

%    c = threshods(t);
   fprintf('result %d vs %d = %f\n',x,y,c)

    res = struct('c',c,'x',x,'y',y,'i',i,'name_x',dire(x).name,'name_y',dire(y).name);
 
    [c]

    writemyfile(fi,res)

end

end
                                                                                
disp('done')    

%% Reconstitute
cd(res_folder)

n = 10; %//Change this depending on size of database

dmat=zeros(n);

res = dir('res_*.mat');
nres = length(res);

for k=1:nres
    rk = load(res(k).name);
rk = rk.var;
    ik = rk.x;
    jk = rk.y;
    d  = rk.c;
    dmat(ik,jk)=d;
    %if rem(k,)
end

dmat = max(dmat,dmat');

save('output_dmat.mat','dmat')

%% Make labels
cd(workfolder);
dire=dir('d*');
labels=cell(size(dire));

for ii=1:length(labels)
    nm=dire(ii).name;
    labels{ii}=[nm(3:end-4)];
end
cd(mainfolder);


%% Plot dendrogram

figure
M=squareform(dmat);
Y=linkage(M);
dendrogram(Y,0,'Orientation','right','Labels',labels);
