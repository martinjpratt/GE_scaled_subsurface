function regional_slab(slab,b_depth)

%creates a polygon kml of files in the folder 'Slab1.0' which should be
%within this directory. The original files have been decimated to reduce
%the size and loading time of the KML files.
%
%Slab 1.0
%Hayes, G. P., D. J. Wald, and R. L. Johnson (2012), Slab1.0: A three-dimensional model of global subduction zone geometries, J. Geophys. Res., 117, B01302, doi:10.1029/2011JB008524.
%
%Written by:
%Martin Pratt, 2015

xyz=dlmread(['./Slab1.0/' slab '_slab1.0_clip.xyz']);

R=6378.1; %in km
scaling=R/(R-b_depth);
[x,y]=meshgrid(unique(xyz(:,2)),unique(xyz(:,1)));
z=reshape(xyz(:,3),numel(unique(xyz(:,1))),numel(unique(xyz(:,2))));

FV=surf2patch(y(1:10:end,1:10:end),fliplr(x(1:10:end,1:10:end)),((b_depth+z(1:10:end,1:10:end)).*1000.*scaling),'triangles');

fid=fopen([slab '.kml'],'w');
fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(fid,'<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">\n');
fprintf(fid,'<Document>\n');
fprintf(fid,['	<name>' slab '.kml</name>\n']);
fprintf(fid,'	<Style id="s_ylw-pushpin">\n');
fprintf(fid,'		<IconStyle>\n');
fprintf(fid,'			<scale>1.1</scale>\n');
fprintf(fid,'			<Icon>\n');
fprintf(fid,'				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>\n');
fprintf(fid,'			</Icon>\n');
fprintf(fid,'			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/>\n');
fprintf(fid,'		</IconStyle>\n');
fprintf(fid,'		<LineStyle>\n');
fprintf(fid,'			<color>00ffffff</color>\n');
fprintf(fid,'		</LineStyle>\n');
fprintf(fid,'		<PolyStyle>\n');
fprintf(fid,'			<color>80ff9900</color>\n');
fprintf(fid,'		</PolyStyle>\n');
fprintf(fid,'	</Style>\n');
fprintf(fid,'	<Style id="s_ylw-pushpin_hl">\n');
fprintf(fid,'		<IconStyle>\n');
fprintf(fid,'			<scale>1.3</scale>\n');
fprintf(fid,'			<Icon>\n');
fprintf(fid,'				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>\n');
fprintf(fid,'			</Icon>\n');
fprintf(fid,'			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/>\n');
fprintf(fid,'		</IconStyle>\n');
fprintf(fid,'		<LineStyle>\n');
fprintf(fid,'			<color>00ffffff</color>\n');
fprintf(fid,'		</LineStyle>\n');
fprintf(fid,'		<PolyStyle>\n');
fprintf(fid,'			<color>80ff9900</color>\n');
fprintf(fid,'		</PolyStyle>\n');
fprintf(fid,'	</Style>\n');
fprintf(fid,'	<StyleMap id="m_ylw-pushpin">\n');
fprintf(fid,'		<Pair>\n');
fprintf(fid,'			<key>normal</key>\n');
fprintf(fid,'			<styleUrl>#s_ylw-pushpin</styleUrl>\n');
fprintf(fid,'		</Pair>\n');
fprintf(fid,'		<Pair>\n');
fprintf(fid,'			<key>highlight</key>\n');
fprintf(fid,'			<styleUrl>#s_ylw-pushpin_hl</styleUrl>\n');
fprintf(fid,'		</Pair>\n');
fprintf(fid,'	</StyleMap>\n');
      
        
        numpts=numel(FV.faces(:,1));
        for n=1:numpts
            if isnan(FV.vertices(FV.faces(n,1),3))
                continue
            elseif isnan(FV.vertices(FV.faces(n,2),3))
                continue
            elseif isnan(FV.vertices(FV.faces(n,3),3))
                continue
            else
fprintf(fid,'	<Placemark>\n');
fprintf(fid,'		<name>Untitled Polygon</name>\n');
fprintf(fid,'		<styleUrl>#m_ylw-pushpin</styleUrl>\n');
fprintf(fid,'		<Polygon>\n');
fprintf(fid,'			<tessellate>1</tessellate>\n');
fprintf(fid,'			<altitudeMode>absolute</altitudeMode>\n');
fprintf(fid,'			<outerBoundaryIs>\n');
fprintf(fid,'				<LinearRing>\n');
fprintf(fid,'					<coordinates>\n');

            T=[FV.vertices(FV.faces(n,1),1) FV.vertices(FV.faces(n,1),2) (FV.vertices(FV.faces(n,1),3)) FV.vertices(FV.faces(n,2),1) FV.vertices(FV.faces(n,2),2) (FV.vertices(FV.faces(n,2),3)) FV.vertices(FV.faces(n,3),1) FV.vertices(FV.faces(n,3),2) (FV.vertices(FV.faces(n,3),3)) FV.vertices(FV.faces(n,1),1) FV.vertices(FV.faces(n,1),2) (FV.vertices(FV.faces(n,1),3))];
            fprintf(fid,'%f,%f,%f %f,%f,%f %f,%f,%f %f,%f,%f\n',T');

fprintf(fid,'                   </coordinates>\n');
fprintf(fid,'               </LinearRing>\n');
fprintf(fid,'			</outerBoundaryIs>\n');
fprintf(fid,'		</Polygon>\n');
fprintf(fid,'   </Placemark>\n');
            end
        end
fprintf(fid,'</Document>\n');
fprintf(fid,'</kml>');
fclose(fid);
end