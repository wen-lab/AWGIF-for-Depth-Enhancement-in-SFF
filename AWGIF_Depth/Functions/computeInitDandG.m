function [depth,G1] = computeInitDandG(img)
    G1=round(mean(img,3)); % mean intensity in ImgSeq along z direction

    %% Compute Focus measure Volume and Depth
    FV=GLV(img);
    [maxF,depth]=max(FV,[],3);

end