data1=textread('C:\Users\Lv\Desktop\data\iPro54\iPro54_data.txt','%s');
D=char(data1);
b1=size(D,1);
b2=size(D,2);
data2=textread('C:\Users\Lv\Desktop\data\iPro54\K_tupledata.txt','%s');
C=char(data2);
c=size(C,1);
test_data=[];
for i=1:b1
    F=[];
    for k=1:c 
        m=0;
        for j=1:b2-6
             if [D(i,j) D(i,j+1) D(i,j+2) D(i,j+3) D(i,j+4) D(i,j+5) D(i,j+6)]==[C(k,1) C(k,2) C(k,3) C(k,4) C(k,5) C(k,6) C(k,7)]
              m=m+1;        
             end
        end
        E=m/c;
        F=[F E];
    end
    test_data=[test_data;F];
end