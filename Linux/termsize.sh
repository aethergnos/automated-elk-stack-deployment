#!/bin/sh
tput lines | tr -d '\n'; echo "x" | tr -d '\n'; tput cols
