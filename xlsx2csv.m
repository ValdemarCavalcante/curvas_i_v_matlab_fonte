function xlsx2csv(pathxlsx, varargin,sname) 
% xlsx2csv(path, varargin) 
% path is the path of xlsx file
% varargin is the path for target fold to save the csv files
% linrenwen@gmail.com
% °ÑxlsxÎÄ¼þÖÐµÄ±íÅúÁ¿×ª»»ÎªcsvÎÄ¼þ 
if nargin >= 2
    path2 = varargin;
    if path2(end) ~= '\' 
        path2 = [path2, '\']; 
    end 
end
Excel = actxserver('Excel.Application'); 
Excel.DefaultFilePath = pathxlsx; 
Excel.DisplayAlerts = false; 
disp(['Transforming the xlsx file: ', pathxlsx]); 
Workbook = Excel.WorkBooks.Open(pathxlsx); 
Sheets = Excel.ActiveWorkbook.Sheets;
nsheet = Sheets.Count;
for jj = 1:nsheet
    hsheet = Sheets.Item(jj);
    Workbook.Sheets.Item(jj).Activate()
    if nargin == 1
        filename = [ sname, '.csv']; 
    elseif nargin >= 2
        filename = [path2 sname, '.csv']; 
    end
    
    Excel.DisplayAlerts = false; 
    hsheet.SaveAs(filename, 6); 
end
 
if nargin == 2
        disp(['Save the csv files to : ', path2]); 
end
Workbook.Close; 
Excel.Quit; 
Excel.delete();
clear Excel;
clear Workbook;
clear Sheets;
end