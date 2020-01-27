% Open dicom images and separate them depending on scan options
% 03_09_2019 og 07.01.2020
% Nå fungerer det til bilder fra Siemens, men kan fungere til bilder fra
% GE, hvis vi bytter nøkkelord "SeriesDescription" med noe annet til GE.
% Dette programmet finner aller Series Description og sorterer bilder i
% egen mappa med samme navn som Series. Description. 
% 
% Maria Stavrinou på NUK, 2020.

clear all 
close all
%% Give the directory where the data is. 
raw_path='C:\Users\Maria\Desktop\CT_Symbia_INTEVO_bold_bilder\usortert\'
cd(raw_path)
% Find all the files inside the directory above
files_namesZ=dir('Fysiker.CT.*')

% Siemens 0018,0050  Slice Thickness: 3 
% Detect how many different scan modes exist 
% USE SERIES DESCRIPTION
for j=1:length(files_namesZ)
    temp_file=files_namesZ(j).name;
     info = dicominfo(temp_file);
         info_scan_mode{j,:}=info.SeriesDescription;
         info_scan_mode_str{j,:}=num2str(info.SeriesDescription);
         clear temp_file info 
end
clear j

% % Show unique names of scan types
 unique_scan_types=unique(info_scan_mode); % cell 

for jjj=1:length(unique_scan_types) 
    display(['>>> Working on ' num2str(jjj)])
    index_scantype1=[]; 
    scan_type=unique_scan_types(jjj);
    scan_type_char=char(unique_scan_types(jjj));
    display(['>>>>>>>>>>>>>>>> & working on ' scan_type_char])
    nymappe=scan_type_char;
    mkdir(nymappe);
    togo_path=[raw_path nymappe '\'];
    % Divide all the images in the fields in the scan types 
    % this can run only at first time 
    for kk=1:length(files_namesZ)% all the 1132 files 
        display(['>>><<<<<<<<<<< Working on ' num2str(kk)])
        temp_filename=files_namesZ(kk).name;
        temp_filename_char=char(temp_filename);
        display(['............ Working on ' temp_filename_char])
        if strcmp(scan_type_char, info_scan_mode{kk,:})==1
            index_scantype_this=[index_scantype1 kk];
            
            inputFullFileName=fullfile(raw_path, temp_filename);
            new_temp_name4=[temp_filename_char];
            outputFullFileName=fullfile(togo_path, new_temp_name4);
            copyfile(inputFullFileName, outputFullFileName);
        end
        %index_scantype_this togo_path inputFullFileName new_temp_name4 outputFullFileName
    end
end


 % END 2020
%     for jk=1:length(index_scantype)
%         temp_index1=index_scantype(jk);
%         togo_path=[raw_path nymappe '\'];
%         % Here
%         temp_name=files_namesZ(temp_index1).name;
%         temp_name_char=char(temp_name)
%         
%         inputFullFileName=fullfile(raw_path, temp_name);
%         new_temp_name4=[temp_name_char '_'  scan_type_char];
%         outputFullFileName=fullfile(togo_path, new_temp_name4);
%         copyfile(inputFullFileName, outputFullFileName);
%     end % moving all the indexes - from these the files to new directory
%     
%     end % for all the filenames
%     
% %end % for all unique scan types
%-----------
%     %if info.SliceThickness==3
%               togo_path=[raw_path nymappe '\'];
%             inputFullFileName=fullfile(raw_path, temp_name);
%             new_temp_name4=[temp_name_char];
%             outputFullFileName=fullfile(togo_path, new_temp_name4);
%             copyfile(inputFullFileName, outputFullFileName);
%         end
% end