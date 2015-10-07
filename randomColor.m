%Fonksiyon, RGB degerlerini random atayarak random olarak renk uretir
function color = randomColor
% Define the two colormaps.
cmap1 = hot(15);
cmap2 = winter(15);
% Combine them into one tall colormap.
combinedColorMap = [cmap1; cmap2];
% Pick 15 rows at random.
randomRows = randi(size(combinedColorMap, 1), [15, 1]);
% Extract the rows from the combined color map.
randomColors = combinedColorMap(randomRows, :);
color = randomColors( randi(length(randomColors)) , : );