function regional_plate_boundaries(b_depth)

%Creates plateboundaries_usgs_regional.kml from the USGS...requires both an edited 
%plateboundaries_usgs.kml and Plates_legend_0.png files in the current working
%directory. Somewhat simple by just replacing a number within the original
%KML file. The resulting KML will show a global plate boundary map scaled
%to the b_depth.
%
%Written by:
%Martin Pratt, 2015

R=6378.1; %in km
scaling=R/(R-b_depth);
scaling_surf=(b_depth-0).*1000*scaling;

fin = fopen('plateboundaries_usgs.kml');
fout = fopen('plateboundaries_usgs_regional.kml','w');

while ~feof(fin)
   s = fgetl(fin);
   s = strrep(s, '6.378e+06', num2str(scaling_surf));
   fprintf(fout,'%s',s);
end

fclose(fin);
fclose(fout);
end