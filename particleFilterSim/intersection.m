function [ crossingPoint] = intersection(infVec1,line2)
%INTERSECTION calculates the intersection point between an infinite vector
%and a bounded line
%   infVec1Point1 = [0 0];
%   infVec1Point2 = [1 2];
%   infVec1 = [infVec1Point1 infVec1Point2];
%   line2Point1 = [2 3];
%   line2Point2 = [1 0];
%   line2 = [line2Point1 line2Point2];
%   crossingpoint = [1.5 3];

d1 = (infVec1(:,1)-line2(:,1));
d2 = (infVec1(:,2)-line2(:,2));
d3 = (((line2(:,4)-line2(:,2)).*(infVec1(:,3)-infVec1(:,1))-(line2(:,3)-line2(:,1)).*(infVec1(:,4)-infVec1(:,2))));

ua = ((line2(:,3)-line2(:,1)).*d2 -(line2(:,4)-line2(:,2)).*d1)./d3;

ub = ((infVec1(:,3)-infVec1(:,1)).*d2-(infVec1(:,4)-infVec1(:,2)).*d1)./d3;

% filter = ub >= 0 & ub <= 1 & ua >= 0 & ua <= 1
filter = ub >= 0 & ub <= 1 & ua>=0; %
crossingPoint =[infVec1(:,1)+ua.*(infVec1(:,3)-infVec1(:,1)) infVec1(:,2)+ua.*(infVec1(:,4)-infVec1(:,2))];
ind = find(filter == 0);
crossingPoint(ind,:) = NaN(length(ind),2);
end


