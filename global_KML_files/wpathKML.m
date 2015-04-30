%% wpathKML
%Script to write a KML file for showing ray paths in Google Earth in 3D
%based on scaling the Earth to the size of the outer core.
%
%***!!!REQUIRES MatTaup to be installed!!!***
%
%Inputs: evt: event location matrix nx3 containing n events' lat lon and
%             depth(km)
%        sta: station location matrix nx2 containing n stations' lat lon
%        phase: Enter which phases you want to plot eg. 'S,ScS,SS'
%        model: Enter 1D Earth model eg. 'prem' or 'iasp91'
%        outfile: Output file name
%
%Written by:
%Martin Pratt, 2015

%Event location: lat lon depth (multiple events can be used)
evt=[18.7 -106.8 10];
%station location: lat lon (multiple stations can be used)
sta=[35.2 -80.8];

%phases and model
phase={'P,S'}; %multiple phases can be used
model='iasp91';
%output KML file
outfile='example_raypaths';

%%
fid=fopen([outfile '.kml'],'w');

fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(fid,'<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">\n');
fprintf(fid,'<Document>\n');
fprintf(fid,'	<name>path1.kml</name>\n');
fprintf(fid,'	<open>1</open>\n');
fprintf(fid,'	<Style id="sh_star">\n');
fprintf(fid,'		<IconStyle>\n');
fprintf(fid,'			<color>ff0000ff</color>\n');
fprintf(fid,'			<scale>1.4</scale>\n');
fprintf(fid,'			<Icon>\n');
fprintf(fid,'				<href>http://maps.google.com/mapfiles/kml/shapes/star.png</href>\n');
fprintf(fid,'			</Icon>\n');
fprintf(fid,'		</IconStyle>\n');
fprintf(fid,'		<ListStyle>\n');
fprintf(fid,'		</ListStyle>\n');
fprintf(fid,'	</Style>\n');
fprintf(fid,'	<Style id="sh_ylw-pushpin">\n');
fprintf(fid,'		<IconStyle>\n');
fprintf(fid,'			<scale>1.3</scale>\n');
fprintf(fid,'			<Icon>\n');
fprintf(fid,'				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>\n');
fprintf(fid,'			</Icon>\n');
fprintf(fid,'			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/>\n');
fprintf(fid,'		</IconStyle>\n');
fprintf(fid,'		<LineStyle>\n');
fprintf(fid,'			<color>ff0000ff</color>\n');
fprintf(fid,'			<width>2</width>\n');
fprintf(fid,'		</LineStyle>\n');
fprintf(fid,'	</Style>\n');
fprintf(fid,'	<StyleMap id="msn_ylw-pushpin">\n');
fprintf(fid,'		<Pair>\n');
fprintf(fid,'			<key>normal</key>\n');
fprintf(fid,'			<styleUrl>#sn_ylw-pushpin</styleUrl>\n');
fprintf(fid,'		</Pair>\n');
fprintf(fid,'		<Pair>\n');
fprintf(fid,'			<key>highlight</key>\n');
fprintf(fid,'			<styleUrl>#sh_ylw-pushpin</styleUrl>\n');
fprintf(fid,'		</Pair>\n');
fprintf(fid,'	</StyleMap>\n');
fprintf(fid,'	<Style id="sn_star">\n');
fprintf(fid,'		<IconStyle>\n');
fprintf(fid,'			<color>ff0000ff</color>\n');
fprintf(fid,'			<scale>1.2</scale>\n');
fprintf(fid,'			<Icon>\n');
fprintf(fid,'				<href>http://maps.google.com/mapfiles/kml/shapes/star.png</href>\n');
fprintf(fid,'			</Icon>\n');
fprintf(fid,'		</IconStyle>\n');
fprintf(fid,'		<ListStyle>\n');
fprintf(fid,'		</ListStyle>\n');
fprintf(fid,'	</Style>\n');
fprintf(fid,'	<Style id="s_ylw-pushpin_hl">\n');
fprintf(fid,'		<IconStyle>\n');
fprintf(fid,'			<color>ffff0000</color>\n');
fprintf(fid,'			<scale>1.4</scale>\n');
fprintf(fid,'			<Icon>\n');
fprintf(fid,'				<href>http://maps.google.com/mapfiles/kml/shapes/triangle.png</href>\n');
fprintf(fid,'			</Icon>\n');
fprintf(fid,'		</IconStyle>\n');
fprintf(fid,'		<ListStyle>\n');
fprintf(fid,'		</ListStyle>\n');
fprintf(fid,'	</Style>\n');
fprintf(fid,'	<Style id="sn_ylw-pushpin">\n');
fprintf(fid,'		<IconStyle>\n');
fprintf(fid,'			<scale>1.1</scale>\n');
fprintf(fid,'			<Icon>\n');
fprintf(fid,'				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>\n');
fprintf(fid,'			</Icon>\n');
fprintf(fid,'			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/>\n');
fprintf(fid,'		</IconStyle>\n');
fprintf(fid,'		<LineStyle>\n');
fprintf(fid,'			<color>ff0000ff</color>\n');
fprintf(fid,'			<width>2</width>\n');
fprintf(fid,'		</LineStyle>\n');
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
fprintf(fid,'	<StyleMap id="msn_star">\n');
fprintf(fid,'		<Pair>\n');
fprintf(fid,'			<key>normal</key>\n');
fprintf(fid,'			<styleUrl>#sn_star</styleUrl>\n');
fprintf(fid,'		</Pair>\n');
fprintf(fid,'		<Pair>\n');
fprintf(fid,'			<key>highlight</key>\n');
fprintf(fid,'			<styleUrl>#sh_star</styleUrl>\n');
fprintf(fid,'		</Pair>\n');
fprintf(fid,'	</StyleMap>\n');
fprintf(fid,'	<Style id="s_ylw-pushpin">\n');
fprintf(fid,'		<IconStyle>\n');
fprintf(fid,'			<color>ffff0000</color>\n');
fprintf(fid,'			<scale>1.2</scale>\n');
fprintf(fid,'			<Icon>\n');
fprintf(fid,'				<href>http://maps.google.com/mapfiles/kml/shapes/triangle.png</href>\n');
fprintf(fid,'			</Icon>\n');
fprintf(fid,'		</IconStyle>\n');
fprintf(fid,'		<ListStyle>\n');
fprintf(fid,'		</ListStyle>\n');
fprintf(fid,'	</Style>\n');
        
for pn=1:numel(phase)
            fprintf(fid,'	<Folder>\n');
            fprintf(fid,'   <name>');
            fprintf(fid,cell2mat(phase(pn)));
            fprintf(fid,'</name>\n');
for ect=1:numel(evt(:,1))
    if isnan(evt(ect,3))
        continue
    end
    for ct=1:numel(sta(:,1))

        TT=tauppath('mod',model,'dep',evt(ect,3),'ph',cell2mat(phase(pn)),'sta',sta(ct,:),'evt',evt(ect,1:2));

        for n=1:numel(TT)      %uncomment to show all arrivals
            X=[TT(n).path.longitude TT(n).path.latitude (2889-TT(n).path.depth).*1000.*2.2077];

            fprintf(fid,'	<Placemark>\n');
            fprintf(fid,'		<name>Untitled Path</name>\n');
            fprintf(fid,'		<styleUrl>#msn_ylw-pushpin</styleUrl>\n');
            fprintf(fid,'		<LineString>\n');
            fprintf(fid,'			<tessellate>1</tessellate>\n');
            fprintf(fid,'			<altitudeMode>absolute</altitudeMode>\n');
            fprintf(fid,'			<coordinates>\n');
            fprintf(fid,'%f,%f,%f\n',X');
            fprintf(fid,'			</coordinates>\n');
            fprintf(fid,'		</LineString>\n');
            fprintf(fid,'	</Placemark>\n');
        end

    end
end
    fprintf(fid,'	</Folder>\n');
end
fprintf(fid,'</Document>\n');
fprintf(fid,'</kml>');
fclose(fid);