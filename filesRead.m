function y = filesRead(folder)
%receive the name of the folder read all .jpg files
    files = dir(folder+"*.jpg");
    numfiles = length(files);
    y = cell(1, numfiles);
    for k = 1:numfiles
        y{k} = imread(strcat(folder, files(k).name));
    end
end