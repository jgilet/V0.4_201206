# Script that enables to compare the 3D energy of the state obtained from the current model and the reference.

echo "This script uses matlab ! Is it installed ?"
echo "#which matlab       : " $(which matlab)

echo "This script uses the executable that already has been compiled:"
exe="./exe/nh"
echo "#ls -al $exe    :" $(ls -al $exe)
echo "-------------------------"
echo "computation: "
dirc=$(pwd)

mkdir $dirc/.test_energy 2> /dev/null

cat tools/namelist_ref | sed "s/dirout/@ @/g" | cut -d@ -f1-2 | sed "sQ@Qdirout=\"$dirc/.test_energy/\"\/Qg" > _namelist_temp

time $exe < _namelist_temp > log_test

echo "-------------------------"
cat log_test | grep "kinetic energy" | cut -d= -f2 > _values_current
diff_cr=$(diff _values_current tools/_values_reference)
echo "difference between the current model and reference on 10 time steps:"
#echo $diff_cr

touch _value_diff
matlab -nodesktop < tools/test_energy.m > /dev/null 2> /dev/null
cat _value_diff
echo " "
echo "-------------------------"

rm _namelist_temp
rm _values_current
rm _value_diff
rm -Rf $dirc/.test_energy 
rm log_test
