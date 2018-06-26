function write4libsvm 
% 为了使得数据满足libsvm的格式要求而进行的数据格式转换 注意原始格式是mat的数据格式，转化成txt或者dat都可以。
% 原始数据保存格式为: 
%             [标签 第一个属性值 第二个属性值...] 
% 转换后文件格式为满足libsvm的格式要求，即: 
%             [标签 1:第一个属性值 2:第二个属性值 3:第三个属性值 ...] 
% Genial@ustc 
% 2004.6.16 
[filename, pathname] = uigetfile( {'*.mat', ... 
       '数据文件(*.mat)'; ... 
       '*.*',                   '所有文件 (*.*)'}, ... 
   '选择数据文件'); 
try 
   S=load([pathname filename]); 
   fieldName = fieldnames(S); 
   str = cell2mat(fieldName); 
   B = getfield(S,str); 
   [m,n] = size(B); 
   [filename, pathname] = uiputfile({'*.txt;*.dat' ,'数据文件(*.txt;*.dat)';'*.*','所有文件 (*.*)'},'保存数据文件'); 
   fid = fopen([pathname filename],'w'); 
   if(fid~=-1) 
       for k=1:m 
           fprintf(fid,'%3d',B(k,1)); 
           for kk = 2:n 
               fprintf(fid,'\t%d',(kk-1)); 
               fprintf(fid,':'); 
               fprintf(fid,'%d',B(k,kk)); 
           end 
           k 
           fprintf(fid,'\n'); 
       end 
       fclose(fid); 
   else 
       msgbox('无法保存文件!'); 
   end 
catch 
end