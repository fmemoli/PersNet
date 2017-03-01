%% demoDowkerHippo
% Script to compute Dowker persistence barcodes from small hippocampus
% database

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

clear all
mainfolder=pwd;
skelfolder=[mainfolder,'/Hippo25/allSkeleta/'];
barfolder=[mainfolder,'/Hippo25/allBarcodes/'];
resfolder=[mainfolder,'/Hippo25/res_bottleneck/'];
rehash();
mkdir(barfolder);
mkdir(resfolder);
import edu.stanford.math.plex4.*;

%% PlotBarcodes; 
%This step is time consuming. It computes barcodes from the precomputed
%skeleta.
cd(skelfolder)

dire=dir('*hole*.mat');

for ii=1:length(dire)
    res_name=dire(ii).name(1:end-4);%remove '.mat'
    if ~exist([skelfolder,res_name,'.fig'],'file')
        A=load(dire(ii).name);
        [sk0,sk1,sk2,diam]=pulltruncatedsk(A);
        sk3=[];
        computePers(sk0,sk1,sk2,sk3,diam,res_name,barfolder);
%         saveas(gcf,res_name);
        close all
    end
end

cd(mainfolder);

%% DPers; 
% This step computes bottleneck distances between pairs of barcodes
cd(barfolder);
dire=dir('bars*.mat');
numFiles=length(dire);
p=nchoosek(1:numFiles,2);

for i=1:length(p) %edit this to 1:length(p)

    x=p(i,1);
    y=p(i,2);
    
    ni = sprintf('res_%d_%d.mat',x,y);
    fi = [resfolder ni];%change slash depending on local/terminal
    
    if ~exist(fi,'file')

    intA=load(dire(x).name);
    intA=intA.bars;
    intB=load(dire(y).name);
    intB=intB.bars;
    
    
    [f,~,~] = distBarcode(intA{1},intB{1});
    [~,~,cm] = bottleneck(f);
    bottleneck_distance_dim0 = cm;
    [f,~,~] = distBarcode(intA{2},intB{2});
    [~,~,cm] = bottleneck(f);
    bottleneck_distance_dim1=cm;
       
intervalsA=[];
interalsB=[];
intervalsA_dim0=[];
intervalsA_dim1=[];
intervalsB_dim0=[];
intervalsB_dim1=[];
    fprintf('result %d vs %d = %f\n',x,y,bottleneck_distance_dim0)
    fprintf('result %d vs %d = %f\n',x,y,bottleneck_distance_dim1)

    res = struct('x',x,'y',y,'dim0_bdist',bottleneck_distance_dim0,'dim1_bdist',bottleneck_distance_dim1,'name_x',dire(x).name,'name_y',dire(y).name);
 
    writemyfile(fi,res)
    end
end

%% reconstBottleneck;
% This step places the pairwise bottleneck distances into matrix form
cd(resfolder);
n = 25; %//Change this depending on size of database
b0mat = zeros(n);
b1mat=zeros(n);

res = dir('res_*.mat');
nres = length(res);

for k=1:nres
    rk = load(res(k).name);
rk = rk.var;
    ik = rk.x;
    jk = rk.y;
    b0 = rk.dim0_bdist;
    b1 = rk.dim1_bdist;
    
    b0mat(ik,jk)=b0;
    b1mat(ik,jk)=b1;
    %if rem(k,)
end

b0mat = max(b0mat,b0mat');
b1mat = max(b1mat,b1mat');

save('output_dim0.mat','b0mat')
save('output_dim1.mat','b1mat')

%% Create labels
cd(barfolder);
dire=dir('bars*');
labels=cell(size(dire));

for ii=1:length(labels)
    nm=dire(ii).name;
    labels{ii}=[nm(6),'-',nm(11:12)];
end
cd(mainfolder);
%% Plot dendrogram with labels
figure
M=squareform(b1mat);
Y=linkage(M);
dendrogram(Y,0,'Orientation','right','Labels',labels);
