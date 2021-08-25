%%  parameters for the size of the plane
sizeP_X = 30;
sizeP_Y = 30;

%%  read data  
xyz = readtable('coordinates.csv');
%load XYZ;

%%  calculate the center of mass
%Xmass = mean(XYZ(:,1));
%Ymass = mean(XYZ(:,2));
%Zmass = mean(XYZ(:,3));
Xmass = mean(xyz.Var1(:));
Ymass = mean(xyz.Var2(:));
Zmass = mean(xyz.Var3(:));

%%  calculate principle components
XYZ = [xyz.Var1(:), xyz.Var2(:), xyz.Var3(:)];
PCA_XYZ = pca(XYZ);

PCA_3X = PCA_XYZ(1,3);
PCA_3Y = PCA_XYZ(2,3);
PCA_3Z = PCA_XYZ(3,3);

%%  derive the plane
for simX = 1:sizeP_X
  for simY = 1:sizeP_Y
    simZ(simY,simX) = Zmass - (PCA_3X*(simX - Xmass))./PCA_3Z - (PCA_3Y*(simY - Ymass))./PCA_3Z;
  end
end

%%  visualize the derived plane
figure;surf(simZ);hold on;
plot3(xyz.Var1(:),xyz.Var2(:),xyz.Var3(:),'o');
%plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3),'o');
%plot3(Xmass,Ymass,Zmass,'ro');

