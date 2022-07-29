function savecf(title)

currentFolder = pwd;

saveas(gcf, currentFolder + "\" +  title + ".png");
saveas(gcf, currentFolder + "\" +  title + ".fig");

end