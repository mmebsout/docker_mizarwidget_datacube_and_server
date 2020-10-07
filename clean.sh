#!/usr/bin/env bash
docker container stop mizarwidget-datacube_and_server
docker container rm mizarwidget-datacube_and_server 

if [ -f $PWD/datacube_workspace  ]; 
then
	echo -n "Delete volume folders (y/n)? "
	read answere
	if [ "$answer" != "${answer#[Yy]}" ] ;
	then
	rm -rf $PWD/datacube_workspace 
	rm -rf $PWD/conf
	echo -n "volumes deleted"
	else
	echo -n "volumes kept"
	fi
fi