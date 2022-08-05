#!/bin/bash

if [ $(nodetool statusbinary) = "running" ]
then
	exit 0
fi
	exit 1
