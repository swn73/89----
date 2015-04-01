%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                    
%       author:夏华林                
%       data:August 11, 2014  
%       version:1.0
%
% Copyright notice:
%       Free use of the Midge Classify is
%       permitted under the guidelines and 
%       in accordance with the most current
%       version of the Common Public License.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('%');
disp('%         title:Midge Classify');
disp('%         author:夏华林');
disp('%         data:August 11, 2014');
disp('%         version:1.0');
disp('%'); 
disp('% Copyright notice:');
disp('%       Free use of the Midge Classify is');
disp('%       permitted under the guidelines and ');
disp('%       in accordance with the most current');
disp('%       version of the Common Public License.');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

try
    TrainData.group1=load('train_data\group1.mat');
    TrainData.group2=load('train_data\group2.mat');
catch
    disp('Error ==>> No Train Data in:');
    disp(strcat(strcat('Dir:',pwd),'\train_data\'));
end;
figure;hold on;
title('Midge Classify');
xlabel('the Length of Feeler(mm)');ylabel('the Length of Wing(mm)');

min_x=min(min(TrainData.group1.group1(:,1)),min(TrainData.group2.group2(:,1)));
max_x=max(max(TrainData.group1.group1(:,1)),max(TrainData.group2.group2(:,1)));
min_y=min(min(TrainData.group1.group1(:,2)),min(TrainData.group2.group2(:,2)));
max_y=max(max(TrainData.group1.group1(:,2)),max(TrainData.group2.group2(:,2)));
min_x=min_x-(max_x-min_x)/2;
max_x=max_x+(max_x-min_x)/2;
min_y=min_y-(max_y-min_y)/2;
max_y=max_y+(max_y-min_y)/2;
axis([min_x max_x min_y max_y]);
plot(TrainData.group1.group1(:,1),TrainData.group1.group1(:,2),'or');
plot(TrainData.group2.group2(:,1),TrainData.group2.group2(:,2),'xb');


m1=sum(TrainData.group1.group1)/size(TrainData.group1.group1,1);
m2=sum(TrainData.group2.group2)/size(TrainData.group2.group2,1);

s1(1:size(TrainData.group1.group1,2),1:size(TrainData.group1.group1,2))=0;
s2=s1;

for i=1:size(TrainData.group1.group1,1)
    s1=s1+(TrainData.group1.group1(i,:)-m1)'*(TrainData.group1.group1(i,:)-m1);
end;
for i=1:size(TrainData.group2.group2,1)
    s2=s2+(TrainData.group2.group2(i,:)-m2)'*(TrainData.group2.group2(i,:)-m2);
end;
S=s1+s2;   %总类内散布矩阵
w=(m1-m2)/S;

%%%%%%%%%%%%%%%%
w=w./norm(w);
m1ToW=w*m1';
m2ToW=w*m2';
mid=(m1ToW+m2ToW)/2;
coordinate=mid.*w;
if w(2)~=0
    x=min_x:0.001:max_x;
    y=coordinate(2)-w(1)/w(2)*(x-coordinate(1));
else
    x=coordinate(1);
    y=min_y:0.001:max_y;
end

plot(x,y,'k','LineWidth',1);

try
    TestData.test=load('test_data\test.mat');
catch
    disp('Error ==>> No Test Data in:');
    disp(strcat(strcat('Dir:',pwd),'\test_data\'));
end;
plot(TestData.test.test(:,1),TestData.test.test(:,2),'<g');
text(1.7,2.2,'\delta=0.5');
legend('Af','Apf','Boundary','Test',-1);









