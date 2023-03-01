function visualize_pdf(x1, x2, PriorsList, MuList, SigmaList)
%VISUALIZE_PDF Summary of this function goes here
%   Detailed explanation goes here

[X1,X2] = meshgrid(x1,x2);

for i=1:size(PriorsList,1)
    Mu = MuList(i,:,1);
    Sigma = abs(reshape(SigmaList(i,:,:,1),2,2));
    F = PriorsList(i,:,1)*mvnpdf([X1(:) X2(:)],Mu,Sigma(1,:,:));
    for k=2:size(PriorsList,3)
        Mu = MuList(i,:,k);
        Sigma = abs(reshape(SigmaList(i,:,:,k),2,2));
        F = F + PriorsList(i,:,k)*mvnpdf([X1(:) X2(:)],Mu,Sigma(1,:,:));
    end
    
    F = reshape(F,length(x2),length(x1));
    surf(x1,x2,F);
    caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
    pause(0.1)
end
end

