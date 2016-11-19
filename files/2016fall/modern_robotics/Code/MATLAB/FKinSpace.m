%**********************************************************************************************
%****************************  CHAPTER 4: FORWARD KINEMATICS  *********************************
%**********************************************************************************************

function T = FKinSpace(M,Slist,thetalist)
% Takes M: the home configuration (position and orientation) of the end-effector,
% Slist: The joint screw axes in the space frame when the manipulator 
% is at the home position,
% thetalist: A list of joint coordinates.
% Returns T (SE(3)) representing the end-effector frame
% when the joints are at the specified coordinates (i.t.o Space Frame).
% Example Inputs:
%{
  clear;clc;
  M = [[-1,0,0,0]; [0,1,0,6]; [0,0,-1,2]; [0,0,0,1]];
  Slist = [[0,0,1,4,0,0]; [0,0,0,0,1,0]; [0,0,-1,-6,0,-0.1]];
  thetalist =[(pi/2.0),3,pi];
  T = FKinSpace(M,Slist,thetalist)
%}
% Output:
% T =
%   -0.0000    1.0000         0   -5.0000
%    1.0000    0.0000         0    4.0000
%         0         0   -1.0000    1.6858
%         0         0         0    1.0000
n1=size(M);
Slist = Slist';
n2=size(Slist);
n3=size(thetalist);
if n1(1)==4 && n1(2)==4 && n2(1)==6 && n2(2)==n3(2) && n3(1)==1
    T=M;
    for i=1:n2(2)
        T=MatrixExp6(thetalist(n2(2)-i+1)*Slist(:,n2(2)-i+1))*T;
    end
else
    msg = 'Input is not appropriate.';
    error(msg);
end

end

