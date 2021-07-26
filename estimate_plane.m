%%  parameters for the size of the plane
sizeX = 30;
sizeY = 30;

%%  read data  
xyz = readtable('coordinates.csv');

%%  calculate the center of mass
Xmass = mean(xyz.Var1(:));
Ymass = mean(xyz.Var2(:));
Zmass = mean(xyz.Var3(:));

%%  calculate principle components
XYZ = [xyz.Var1(:), xyz.Var2(:), xyz.Var3(:)];
PCA_XYZ = pca(XYZ);

PCA_3X = PCA_XYZ(3,1);
PCA_3Y = PCA_XYZ(3,2);
PCA_3Z = PCA_XYZ(3,3);

%%  derive the plane
for simX = 1:sizeX
  for simY = 1:sizeY
    simZ(simX,simY) = Zmass - (PCA_3X*(simX - Xmass))./PCA_3Z - PCA_3Y*(simY - Ymass)./PCA_3Z;
  end
end

%%  visualize the derived plane
figure;surf(simZ);hold on;
plot3(xyz.Var1(:),xyz.Var2(:),xyz.Var3(:),'o');
