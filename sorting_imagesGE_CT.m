% Open CT dicom images and separate them depending on scan options
% 03_09_2019 og 27.01.202209
% This program is sorting the images based on info.SeriesDescription. 
% Maria Stavrinou på NUK, 2020.
%% Start 
clear all;
close all;
thismoment=datestr(now); 
for jj=1:length(thismoment); if ( thismoment(jj)==':' || thismoment(jj)==' '); thismoment(jj)='-';end; end

%% Give the directory where the data is. 
raw_path='C:\Users\Maria\Desktop\Bilder_usortert_Lillehammer\A\FysikerCatphanHelikal\';
%'C:\Users\Maria\Desktop\CT_Symbia_INTEVO_bold_bilder\usortert\'
cd(raw_path)
% Find all the files inside the directory above

files_namesZ=dir('Z*');

%% Define the criteria to separate them
for j=1:length(files_namesZ)
    temp_file=files_namesZ(j).name;
     info = dicominfo(temp_file);
         info_scan_mode{j,:}=info.SeriesDescription;
         %info_slicethickness(j,:)=info.SliceThickness;
         %info_scan_mode_str{j,:}=num2str(info.SeriesNumber);% PatientName.FamilyName
         clear temp_file info 
end
clear j
% Define unique scan types
unique_scan_types=unique(info_scan_mode); % cell 

disp('*** Unique scan types in those files are: ');
disp(unique_scan_types)
disp('*******************************************');
%% Correct the names for dots and blanks 
% template
% for jj=1:length(thismoment); if ( thismoment(jj)==':' || thismoment(jj)==' '); thismoment(jj)='-';end
unique_scan_types_corr = {}; 
for k=1:length(unique_scan_types)
    temp_23=unique_scan_types(k);
    temp_23=cellstr(temp_23);
    temp_23_b=char(temp_23);
        for kkk=1:length(temp_23_b)
            if (temp_23_b(kkk)=='.' | temp_23_b(kkk)==' ')
                temp_23_b(kkk)='_'; 
            end
        end
        unique_scan_types_corr(k,:)={temp_23_b};
        clear temp_23 temp_23_b
end
clear kkk k 

%% Find number of images of each unique kind - not in use
% for jjj=1:length(files_namesZ)
%     temp_23 =info_scan_mode(jjj);
%     for j=1:length(unique_scan_types)
%         if strcmp(unique_scan_types(j), temp_23)==1
%             
%             index.(unique_scan_types(j))=jjj;
%         end
%     end
%     clear temp_23
% end
% clear j jjj

%% Start main part to separate images. 
    
    for jjj=1:length(unique_scan_types) 
        scan_type=unique_scan_types(jjj);
        scan_type_char=char(scan_type); %char(unique_scan_types(jjj));
        index_scantype_separate=[]; 
        nymappe=scan_type_char;
        mkdir(nymappe);
        togo_path=[raw_path nymappe '\'];

        for kk=1:length(files_namesZ)% all the 1132 files 
            temp_filename=files_namesZ(kk).name;
            temp_filename_char=char(temp_filename);
            % Get the dicominfo and the slice thickness as well.
            temp_scan_type=info_scan_mode(kk);
            if strcmp(scan_type_char, temp_scan_type)==1
                %index_scantype_separate=[index_scantype_separate kk];
                inputFullFileName=fullfile(raw_path, temp_filename);
                new_temp_name=[temp_filename_char];
                outputFullFileName=fullfile(togo_path, new_temp_name);
                copyfile(inputFullFileName, outputFullFileName);
            end
    end % for kk
    clear kk
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