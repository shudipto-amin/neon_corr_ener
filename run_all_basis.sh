#!/bin/bash

bases=(VDZ VTZ VQZ V5Z V6Z)
calc=$1

for basis in ${bases[@]}; do
    echo "Running calculation for cc-p$basis"
    molpro --output neon${calc}_cc-p${basis}.out --name arg_basis=cc-p${basis} neon${calc}.inp
    molpro --output neon${calc}_aug-cc-p${basis}.out --name arg_basis=aug-cc-p${basis} neon${calc}.inp
done       
