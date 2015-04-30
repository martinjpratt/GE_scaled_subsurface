README for scaled_subsurface

###########################################################################
# This is still under development, so many functions may not be fully     #
# commented and certainly not fully debugged. Please feel free to mess    #
# about with them, or let me know if there's any issues with the scripts: #
# martin@seismo.wustl.edu                                                 #
# Thanks!                                                                 #
###########################################################################

Required programs to be preinstalled on Matlab:
irisFetch.m : Download from http://ds.iris.edu/ds/nodes/dmc/software/downloads/irisfetch.m/

To use, type: scaled_subsurface in the Command Window.

To make a set of KML files to load in Google Earth, the GUI 
'scaled_subsurface' will allow the definition of various items that can be 
created. Essentially the scale of the Earth can range from a few km to 
visualize shallow structure, to the core mantle or inner core boundaries to 
visualize more global datasets. Currently 7 options can be created from the 
7 push buttons:
1: A bounding box that contains a scale in 100s of kilometers on each
   corner.
2. A coastline that is overlayed at the new, scaled 'surface' of the Earth.
3. A set of earthquake locations. These are plotted within the model space
   defined by the bounding box. This can be used with a local file or using
   the irisFetch matlab codes.
4. A set of 3-D Global CMT focal mechanism solutions plotted within the 
   model space defined by the bounding box.
5. A plate boundary overlay plotted on the scaled 'surface'. Currently this
   is a global kml so won't be limited to the bounding box.
6. A polygon/polygons of Slab 1.0 subducted plate surfaces in 3-D. This is 
   not defined by the bounding box.
7. A set of 2 layers denoting the depths of the mantle discontinuities at
   410 and 660km.

Default values are inbuilt into the GUI so you can just hit one of the
pushbuttons and an example KML will be made. These KMLs reflect the values
that appear on startup of the GUI.

Spatial Range:
Defined by latitude (+/- 90) and longitude (+/- 180). Work is being made to
make longitude ranges date line friendly. Currently the bounding box and 
irisFetch will work if longitudes are in the east positive range 0-360. The
Coast KML will work but not plot anything greater than 180 if you use this
range. CMT KML will not work and must be in range +/- 180.
Buttons that require these ranges to be specified:
'Generate Box KML'
'Generate Coast KML'
'Generate Discontinuities KML'
'Generate EQ KML'
'Generate CMT KML'

Scaled Depth:
Sets the depth of your region of interest. Essentially the old surface of  
the Earth will now be scaled so that it represents this depth.
Buttons that require these ranges to be specified:
'Generate Box KML'
'Generate Coast KML'
'Generate Discontinuities KML'
'Generate EQ KML'
'Generate CMT KML'
'Generate Plate Boundaries'
'Make Slab'

Event Source:
Allows the user to choose between irisFetch or a local file containing 
source locations. To use irisFetch make sure the matlab codes are installed
prior to using this function (check by typing 'which irisFetch'). The local
file must be of the format:
mm dd yyyy HH MM SS event_lat event_lon event_depth event_magnitude
eg.
01 09 2011 17 35 54 -19.981525 47.1720619 25 3.11696053
Use the 'Input Local File Name' to specify the local file. 'Output KML 
Name' specifies the output file name for the earthquake locations. If
you want to use irisFetch instead, use the labelled boxes to define:
magnitude range
depth range
time range
Definitions within this box are also used to download Global CMT data.

Slab 1.0:
Check boxes of slabs that are defined by the Slab 1.0 models. 1 or more 
slabs can be generated at the same time and produce seperate KML files.

Included in this folder is a script called regional_wpathKML.m. This script
utilizes MatTaup (must be installed prior to running the script, a version 
can be downladed from: https://github.com/g2e/seizmo/tree/master/mattaup) 
and can generate raypaths of phases scaled to your required projection. See 
script for more detailed help.