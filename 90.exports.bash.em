#!/bin/bash

# fix parsing errors (fixes wrong visuals in RViz)
export LC_NUMERIC="en_US.UTF-8"

# load hand setup if given
if [ -f $ROSWSS_ROOT/.hands ]; then
  source $ROSWSS_ROOT/.hands
fi
