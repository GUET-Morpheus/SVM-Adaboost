%% 该代码为基于BP-Adaboost的强分类器分类
%
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.ilovematlab.cn/forum-158-1.html"><font color="#0000FF">板块</font></a>里，对该案例提问，做到有问必答。本套书籍官方网站为：<a href="http://video.ourmatlab.com">video.ourmatlab.com</a></font></span></td></tr><tr>		<td><font size="2">2：点此<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">从当当预定本书</a>：<a href="http://union.dangdang.com/transfer/transfer.aspx?from=P-284318&backurl=http://www.dangdang.com/">《Matlab神经网络30个案例分析》</a>。</td></tr><tr>	<td><p class="comment"></font><font size="2">3</font><font size="2">：此案例有配套的教学视频，视频下载方式<a href="http://video.ourmatlab.com/vbuy.html">video.ourmatlab.com/vbuy.html</a></font><font size="2">。 </font></p></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		4：此案例为原创案例，转载请注明出处（《Matlab神经网络30个案例分析》）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		5：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>		</table>
% </html>
%% 清空环境变量

%% 下载数据
Accuracy=0;

for kk=1:1
t1=ones(161,1);
t2=-t1;
train_label=[t1;t2];
test_data=;

%% 权重初始化
[mm,nn]=size(train_data');
D(1,:)=ones(1,nn)/nn;

%% 弱分类器分类
 K=5;
 for i=1:K
    %训练样本归一化
    [inputn,inputps]=mapminmax(train_data');
    [outputn,outputps]=mapminmax(train_label');
    error(i)=0;
    model2=svmtrain(outputn',inputn','  -s 0  -c 0.75786  -t 0 -g 0.005');
    
    %训练数据预测
    [predictlabel1,accuracy1,decision_values1]=svmpredict(outputn',inputn',model2);
    an1=decision_values1';
    test_simu1(i,:)=mapminmax('reverse',an1,outputps);
    
    %测试数据预测
    inputn_test =mapminmax('apply',test_data',inputps);
    [predictlabel2,accuracy2,decision_values2]=svmpredict(test_label,inputn_test',model2);
    an=decision_values2';
    test_simu(i,:)=mapminmax('reverse',an,outputps);
    
    %统计输出效果
    kk1=find(test_simu1(i,:)>0);
    kk2=find(test_simu1(i,:)<0);
    aa(kk1)=1;
    aa(kk2)=-1;
    
    %统计错误样本数
    for j=1:nn
        if aa(j)~=train_label(j)';
            error(i)=error(i)+D(i,j);
        end
    end
    
    %弱分类器i权重
    at(i)=0.5/exp(abs(error(i)));
    
    %更新D值
    for j=1:nn
        D(i+1,j)=D(i,j)*exp(-at(i)*aa(j)*test_simu1(i,j));
    end
    
    %D值归一化
    Dsum=sum(D(i+1,:));
    D(i+1,:)=D(i+1,:)/Dsum;
    T=[];
    for q=1:size(train_data,2)
    T=[T train_data(:,q).*D(i+1,:)'];
    end
    train_data=T;
end



%% 强分类器分类结果
output=sign(at*test_simu)


end