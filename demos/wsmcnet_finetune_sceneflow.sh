#!/usr/bin/env bash
# -*- coding: UTF-8 -*-

echo -e "************ start of ${0}\n"
set -x

## augments
C=${1-4}
S=${2-2}
echo

arch="WSMCnet"
maxdisp=192
bn=4
crop_width=512
crop_height=256
freq_print=20
lr_stride=10
lr_delay=0.1
echo


## log_dirpath
log_dir="logs"
mkdir -p "${log_dir}"
echo


## sceneflow
dataname="sf"
datapath="/media/qjc/D/data/sceneflow/"
mode="Finetune"
loadmodel="./pretrained/pretrained_sceneflow.tar"
echo

# log_filepath and dir_save
flag="${mode}_${arch}_C${C}S${S}_${mode:0:1}(${dataname})"
LOG="$log_dir/log_${flag}_`date +%Y-%m-%d_%H-%M-%S`.txt"
dir_save="./results/${flag}"
echo

# train model
epochs=6
nloop=1
freq_optim=4
lr=0.001
lr_epoch0=4
python train_val.py --arch $arch --maxdisp $maxdisp --C $C --S $S \
                   --loadmodel $loadmodel \
                   --dataname $dataname --datapath $datapath --bn $bn \
                   --crop_width $crop_width --crop_height $crop_height \
                   --epochs $epochs --nloop $nloop --freq_print $freq_print \
                   --freq_optim $freq_optim \
                   --lr $lr --lr_epoch0 $lr_epoch0 \
                   --lr_stride $lr_stride --lr_delay $lr_delay \
                   --dir_save $dir_save \
                   2>&1 | tee -a "${LOG}"
echo


echo -e "************ end of ${0}\n"
