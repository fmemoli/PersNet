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


function ints = skel2Intervals(sk0,sk1,sk2,diam)

%may need to add javaplex.jar file from javaplex\lib\ directory using javaaddpath

	import edu.stanford.math.plex4.*;
		
	stream = api.Plex4.createExplicitSimplexStream(1);
	for v=1:size(sk0,1);
            stream.addVertex(sk0(v,1),sk0(v,2));
        end

        for e =1:size(sk1,1);
            stream.addElement(sk1(e,1:2), sk1(e,3));
        end

        for f=1:size(sk2,1);
            stream.addElement(sk2(f,1:3),sk2(f,4));
        end

	stream.finalizeStream();
    % compute 2 dimensions (0,1-simplices)with Z2 coeff
    persistence = api.Plex4.getModularSimplicialAlgorithm(2,2);

    intervals=persistence.computeIntervals(stream);
    ints=convertJavaplexToI(intervals);
end
	
