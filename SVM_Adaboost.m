%% �ô���Ϊ����BP-Adaboost��ǿ����������
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">�ð�������������</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1�����˳���פ���ڴ�<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">���</font></a>��Ըð������ʣ��������ʱش𡣱����鼮�ٷ���վΪ��<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2�����<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">�ӵ���Ԥ������</a>��<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">��Matlab������30������������</a>��</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">���˰��������׵Ľ�ѧ��Ƶ����Ƶ���ط�ʽ<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">�� </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4���˰���Ϊԭ��������ת����ע����������Matlab������30����������������</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5�����˰��������������о��й��������ǻ�ӭ���������Ҫ��ȣ����ǿ��Ǻ���Լ��ڰ����</font></span></td>	</tr>		</table>
% </html>
%% ��ջ�������

%% ��������
Accuracy=0;

for kk=1:1
t1=ones(161,1);
t2=-t1;
train_label=[t1;t2];
test_data=;

%% Ȩ�س�ʼ��
[mm,nn]=size(train_data');
D(1,:)=ones(1,nn)/nn;

%% ������������
 K=5;
 for i=1:K
    %ѵ��������һ��
    [inputn,inputps]=mapminmax(train_data');
    [outputn,outputps]=mapminmax(train_label');
    error(i)=0;
    model2=svmtrain(outputn',inputn','  -s 0  -c 0.75786  -t 0 -g 0.005');
    
    %ѵ������Ԥ��
    [predictlabel1,accuracy1,decision_values1]=svmpredict(outputn',inputn',model2);
    an1=decision_values1';
    test_simu1(i,:)=mapminmax('reverse',an1,outputps);
    
    %��������Ԥ��
    inputn_test =mapminmax('apply',test_data',inputps);
    [predictlabel2,accuracy2,decision_values2]=svmpredict(test_label,inputn_test',model2);
    an=decision_values2';
    test_simu(i,:)=mapminmax('reverse',an,outputps);
    
    %ͳ�����Ч��
    kk1=find(test_simu1(i,:)>0);
    kk2=find(test_simu1(i,:)<0);
    aa(kk1)=1;
    aa(kk2)=-1;
    
    %ͳ�ƴ���������
    for j=1:nn
        if aa(j)~=train_label(j)';
            error(i)=error(i)+D(i,j);
        end
    end
    
    %��������iȨ��
    at(i)=0.5/exp(abs(error(i)));
    
    %����Dֵ
    for j=1:nn
        D(i+1,j)=D(i,j)*exp(-at(i)*aa(j)*test_simu1(i,j));
    end
    
    %Dֵ��һ��
    Dsum=sum(D(i+1,:));
    D(i+1,:)=D(i+1,:)/Dsum;
    T=[];
    for q=1:size(train_data,2)
    T=[T train_data(:,q).*D(i+1,:)'];
    end
    train_data=T;
end



%% ǿ������������
output=sign(at*test_simu)


end