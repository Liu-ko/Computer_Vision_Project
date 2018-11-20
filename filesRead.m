function y = filesRead(folder)
%receive the name of the folder read all .jpg files
    files = dir(folder+"*.jpg");
    numfiles = length(files);
    y = cell(1, numfiles);
    if numfiles > 0
        f = waitbar(0, "Loading image set");
        for k = 1:numfiles
            y{k} = imread(strcat(folder, files(k).name));
            waitbar(k/numfiles, f, "Loading image set");
        end
        close(f);
        msgbox("Image set loaded successfully");
    else 
        msgbox("Provided folder does not contain any images");
    end
end