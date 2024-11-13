%writeIMG(Lineas,Columnas,Imagen, ReadFilePath, SaveFilePath)

N = 256;
Lineas = N; Columnas = N;
Imagen = InfoStruct.MapasConductancia{38};
ReadFilePath = 'D:\OneDrive - Universidad Autonoma de Madrid\Doctorado\Análisis\Análisis Matlab\QPIAnalisis\QPI Program\M09_A000_ih.img';
SaveFilePath = 'D:\OneDrive - Universidad Autonoma de Madrid\Doctorado\Análisis\Análisis Matlab\QPIAnalisis\QPI Program\M09_A000_ih_85.img';

writeIMG(Lineas,Columnas,Imagen, ReadFilePath, SaveFilePath)