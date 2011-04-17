#!/bin/bash

cmd="$1"; shift


case "$cmd" in
  encode_mp4)
    src=$1; shift
    dest=$1; shift
    preset="iPhone & iPod Touch"
    HandBrakeCLI -i $src -o $dest -2T --preset="$preset"
    ;;
  concat)
    [ -x /usr/bin/mencoder ] || { sudo apt-get install mencoder || exit 1; }
    outfile="$1"; shift;
    mencoder -ovc copy -oac copy -o $outfile -forceidx $@ && rm $@ && \
      ls -lh $outfile
    ;;
  *)
    echo command not recognized
    ;;
esac
