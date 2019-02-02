#! /bin/bash
# A script that makes five figures, one for each processing center. 

lonW="-121.8"
lonE="-115.0"
latS="32.2"
latN="37.6"
range="$lonW/$lonE/$latS/$latN"
projection="M3.0i"  # used for medium experiments.
horiz_scale=0.1  # used for velocity change vectors (0.3 sometimes, sometimes smaller)
output1='Figures/SoCalAllprocs_2010.ps'
offset=8.5

filename='2010.txt'
file1=pbo_lssq_NA_nosig/
name1="PBO"
file2=cwu_lssq_NA/
name2="CWU"
file3=nmt_lssq_NA/
name3="NMT"
file4=unr_lssq_NA/
name4="UNR NA12"
file5=unr_lssq_ITRF/
name5="UNR IGS08"

gmt makecpt -T-29000/8000/500 -Cgray -Z > blue_topo.cpt

# THE FIRST PLOT
infile=$file1$filename
gmt pscoast -R$range -J$projection -Slightblue -Wthinner,black -N1 -N2 -B2.0WeSn -Dh -K -X2 -Y11 > $output1

gmt grdgradient ../../../Misc/Mapping_Resources/Global_topography_data/ETOPO1_Bed_g_gmt4.grd -A320 -R$range -Getopo1.grad -Nt
gmt grdhisteq etopo1.grad -Getopo1.hist -N
gmt grdinfo etopo1.hist 
gmt grdmath etopo1.hist 8.41977 DIV = etopo1.norm
gmt grdimage ../../../Misc/Mapping_Resources/Global_topography_data/ETOPO1_Bed_g_gmt4.grd -Ietopo1.norm -R$range -J$projection -Cblue_topo.cpt -K -O >> $output1

# Add the plate boundaries
gmt psxy ../../../Misc/Mapping_Resources/transform.gmt -R$range -J$projection -Wthin,red -K -O >> $output1
gmt psxy ../../../Misc/Mapping_Resources/ridge.gmt -R$range -J$projection -Wthin,red -K -O >> $output1
gmt psxy ../../../Misc/Mapping_Resources/trench.gmt -R$range -J$projection -Wthin,red -Sf1.5/0.6+r+t+o1.8 -K -O >> $output1

# Add PBO velocity vectors
awk '{print $1, $2, $3, $4, $7, $8, $8}' $infile | gmt psvelo -R$range -J$projection -O -K -Se$horiz_scale/0.68/8 -A+e+gblack+pthickest -Wthick,black >> $output1
grep 'nan' $infile | awk '{print $1, $2}' | gmt psxy -R$range -J$projection -O -K -Gdarkblue -Sc0.05 >> $output1
gmt psvelo -R$range -J$projection -A+e+gblack+pthickest -Se$horiz_scale/0.68/10 -Wblack -K -O <<EOF >> $output1
-120.5 33.3 2 0 0 0 0.0 2mm/yr
EOF

# Add the labels
gmt pscoast -R$range -J$projection -Lf-121.0/32.8/32.8/50+jt -N1 -N2 -Wthinner,black -Dh -K -O >> $output1
gmt pstext -R$range -J$projection -F+f14p,Helvetica -Gwhite -K -O <<EOF >> $output1
-115.8 37.3 $name1
-121.2 37.3 A
EOF





# THE SECOND PLOT
infile=$file2$filename
gmt pscoast -R$range -J$projection -Slightblue -Wthinner,black -N1 -N2 -B2.0weSn -Dh -O -K -X$offset -Y0 >> $output1 # the title goes here

gmt grdgradient ../../../Misc/Mapping_Resources/Global_topography_data/ETOPO1_Bed_g_gmt4.grd -A320 -R$range -Getopo1.grad -Nt
gmt grdhisteq etopo1.grad -Getopo1.hist -N
gmt grdinfo etopo1.hist 
gmt grdmath etopo1.hist 8.41977 DIV = etopo1.norm
gmt grdimage ../../../Misc/Mapping_Resources/Global_topography_data/ETOPO1_Bed_g_gmt4.grd -Ietopo1.norm -R$range -J$projection -Cblue_topo.cpt -K -O >> $output1

# Add the plate boundaries
gmt psxy ../../../Misc/Mapping_Resources/transform.gmt -R$range -J$projection -Wthin,red -K -O >> $output1
gmt psxy ../../../Misc/Mapping_Resources/ridge.gmt -R$range -J$projection -Wthin,red -K -O >> $output1
gmt psxy ../../../Misc/Mapping_Resources/trench.gmt -R$range -J$projection -Wthin,red -Sf1.5/0.6+r+t+o1.8 -K -O >> $output1

# Add PBO velocity vectors
awk '{print $1, $2, $3, $4, $7, $8, $8}' $infile | gmt psvelo -R$range -J$projection -O -K -Se$horiz_scale/0.68/8 -A+e+gblack+pthickest -Wthick,black >> $output1
grep 'nan' $infile | awk '{print $1, $2}' | gmt psxy -R$range -J$projection -O -K -Gdarkblue -Sc0.05 >> $output1
gmt psvelo -R$range -J$projection -A+e+gblack+pthickest -Se$horiz_scale/0.68/10 -Wblack -K -O <<EOF >> $output1
-120.5 33.3 2 0 0 0 0.0 2mm/yr
EOF

# Add the labels
gmt pscoast -R$range -J$projection -Lf-121.0/32.8/32.8/50+jt -N1 -N2 -Wthinner,black -Dh -K -O >> $output1 
gmt pstext -R$range -J$projection -F+f14p,Helvetica -Gwhite -K -O <<EOF >> $output1
-115.8 37.3 $name2
-121.2 37.3 B
EOF



# THE THIRD PLOT
infile=$file3$filename
gmt pscoast -R$range -J$projection -Slightblue -Wthinner,black -N1 -N2 -B2.0weSn -Dh -O -K -X$offset -Y0 >> $output1 # the title goes here

gmt grdgradient ../../../Misc/Mapping_Resources/Global_topography_data/ETOPO1_Bed_g_gmt4.grd -A320 -R$range -Getopo1.grad -Nt
gmt grdhisteq etopo1.grad -Getopo1.hist -N
gmt grdinfo etopo1.hist 
gmt grdmath etopo1.hist 8.41977 DIV = etopo1.norm
gmt grdimage ../../../Misc/Mapping_Resources/Global_topography_data/ETOPO1_Bed_g_gmt4.grd -Ietopo1.norm -R$range -J$projection -Cblue_topo.cpt -K -O >> $output1

# Add the plate boundaries
gmt psxy ../../../Misc/Mapping_Resources/transform.gmt -R$range -J$projection -Wthin,red -K -O >> $output1
gmt psxy ../../../Misc/Mapping_Resources/ridge.gmt -R$range -J$projection -Wthin,red -K -O >> $output1
gmt psxy ../../../Misc/Mapping_Resources/trench.gmt -R$range -J$projection -Wthin,red -Sf1.5/0.6+r+t+o1.8 -K -O >> $output1

# Add PBO velocity vectors
awk '{print $1, $2, $3, $4, $7, $8, $8}' $infile | gmt psvelo -R$range -J$projection -O -K -Se$horiz_scale/0.68/8 -A+e+gblack+pthickest -Wthick,black >> $output1
grep 'nan' $infile | awk '{print $1, $2}' | gmt psxy -R$range -J$projection -O -K -Gdarkblue -Sc0.05 >> $output1
gmt psvelo -R$range -J$projection -A+e+gblack+pthickest -Se$horiz_scale/0.68/10 -Wblack -K -O <<EOF >> $output1
-120.5 33.3 2 0 0 0 0.0 2mm/yr
EOF

# Add the labels
gmt pscoast -R$range -J$projection -Lf-121.0/32.8/32.8/50+jt -N1 -N2 -Wthinner,black -Dh -K -O >> $output1
gmt pstext -R$range -J$projection -F+f14p,Helvetica -Gwhite -K -O <<EOF >> $output1
-115.8 37.3 $name3
-121.2 37.3 C
EOF



# THE FOURTH PLOT
infile=$file4$filename
gmt pscoast -R$range -J$projection -Slightblue -Wthinner,black -N1 -N2 -B2.0WeSn -Dh -O -K -X-13 -Y-8.5 >> $output1 # the title goes here

gmt grdgradient ../../../Misc/Mapping_Resources/Global_topography_data/ETOPO1_Bed_g_gmt4.grd -A320 -R$range -Getopo1.grad -Nt
gmt grdhisteq etopo1.grad -Getopo1.hist -N
gmt grdinfo etopo1.hist 
gmt grdmath etopo1.hist 8.41977 DIV = etopo1.norm
gmt grdimage ../../../Misc/Mapping_Resources/Global_topography_data/ETOPO1_Bed_g_gmt4.grd -Ietopo1.norm -R$range -J$projection -Cblue_topo.cpt -K -O >> $output1

# Add the plate boundaries
gmt psxy ../../../Misc/Mapping_Resources/transform.gmt -R$range -J$projection -Wthin,red -K -O >> $output1
gmt psxy ../../../Misc/Mapping_Resources/ridge.gmt -R$range -J$projection -Wthin,red -K -O >> $output1
gmt psxy ../../../Misc/Mapping_Resources/trench.gmt -R$range -J$projection -Wthin,red -Sf1.5/0.6+r+t+o1.8 -K -O >> $output1

# Add PBO velocity vectors
awk '{print $1, $2, $3, $4, $7, $8, $8}' $infile | gmt psvelo -R$range -J$projection -O -K -Se$horiz_scale/0.68/8 -A+e+gblack+pthickest -Wthick,black >> $output1
grep 'nan' $infile | awk '{print $1, $2}' | gmt psxy -R$range -J$projection -O -K -Gdarkblue -Sc0.05 >> $output1
gmt psvelo -R$range -J$projection -A+e+gblack+pthickest -Se$horiz_scale/0.68/10 -Wblack -K -O <<EOF >> $output1
-120.5 33.3 2 0 0 0 0.0 2mm/yr
EOF
# Add the labels
gmt pscoast -R$range -J$projection -Lf-121.0/32.8/32.8/50+jt -N1 -N2 -Wthinner,black -Dh -K -O >> $output1
gmt pstext -R$range -J$projection -F+f14p,Helvetica -Gwhite -K -O <<EOF >> $output1
-116.3 37.3 $name4
-121.2 37.3 D
EOF




# THE FIFTH PLOT
infile=$file5$filename
gmt pscoast -R$range -J$projection -Slightblue -Wthinner,black -N1 -N2 -B2.0weSn -Dh -O -K -X$offset -Y0 >> $output1 # the title goes here

gmt grdgradient ../../../Misc/Mapping_Resources/Global_topography_data/ETOPO1_Bed_g_gmt4.grd -A320 -R$range -Getopo1.grad -Nt
gmt grdhisteq etopo1.grad -Getopo1.hist -N
gmt grdinfo etopo1.hist 
gmt grdmath etopo1.hist 8.41977 DIV = etopo1.norm
gmt grdimage ../../../Misc/Mapping_Resources/Global_topography_data/ETOPO1_Bed_g_gmt4.grd -Ietopo1.norm -R$range -J$projection -Cblue_topo.cpt -K -O >> $output1

# Add the plate boundaries
gmt psxy ../../../Misc/Mapping_Resources/transform.gmt -R$range -J$projection -Wthin,red -K -O >> $output1
gmt psxy ../../../Misc/Mapping_Resources/ridge.gmt -R$range -J$projection -Wthin,red -K -O >> $output1
gmt psxy ../../../Misc/Mapping_Resources/trench.gmt -R$range -J$projection -Wthin,red -Sf1.5/0.6+r+t+o1.8 -K -O >> $output1

# Add PBO velocity vectors
awk '{print $1, $2, $3, $4, $7, $8, $8}' $infile | gmt psvelo -R$range -J$projection -O -K -Se$horiz_scale/0.68/8 -A+e+gblack+pthickest -Wthick,black >> $output1
grep 'nan' $infile | awk '{print $1, $2}' | gmt psxy -R$range -J$projection -O -K -Gdarkblue -Sc0.05 >> $output1
gmt psvelo -R$range -J$projection -A+e+gblack+pthickest -Se$horiz_scale/0.68/10 -Wblack -K -O <<EOF >> $output1
-120.5 33.3 2 0 0 0 0.0 2mm/yr
EOF

# Add the labels
gmt pscoast -R$range -J$projection -Lf-121.0/32.8/32.8/50+jt -N1 -N2 -Wthinner,black -Dh -K -O >> $output1
gmt pstext -R$range -J$projection -F+f14p,Helvetica -Gwhite -K -O <<EOF >> $output1
-116.3 37.3 $name5
-121.2 37.3 E
EOF




open $output1

rm gmt.history
rm etopo1.grad
rm etopo1.hist
rm etopo1.norm
