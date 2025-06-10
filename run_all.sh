#!/bin/bash

#set -e

bases=(VDZ VTZ VQZ V5Z V6Z)

if [[ $# -ne 2 ]]; then
    echo "Must pass 2 parameters, calc1 and calc2"
    exit
fi    

calc1=$1
calc2=$2

runname=neon_${calc1}_${calc2}
runname=${runname//(}
runname=${runname//)}

outdir=outputs/${runname}

mkdir -p $outdir
pushd $outdir

for basis in ${bases[@]}; do
    non_diff_basis="cc-p${basis}"
    diff_basis="aug-cc-p${basis}"
    
    non_diff_name="${runname}_${non_diff_basis}"
    diff_name="${runname}_${diff_basis}"

    #out_non_diff="${runname}_${non_diff_basis}.out"
    #out_diff="${runname}_${diff_basis}.out"
    sed "s/\$calc1/$calc1/g
         s/\$calc2/$calc2/g
         s/\$arg_basis/$non_diff_basis/g" ../../neon.inp >> ${non_diff_name}.inp
    sed "s/\$calc1/$calc1/g
         s/\$calc2/$calc2/g
         s/\$arg_basis/$diff_basis/g" ../../neon.inp >> ${diff_name}.inp
    qmolpro-generic -n4 ${non_diff_name}.inp 
    qmolpro-generic -n4 ${diff_name}.inp
done 

popd
    
