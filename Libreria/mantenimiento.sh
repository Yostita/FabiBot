#!/bin/bash

echo -e "\n$(date "+%d-%m-%Y --- %T") --- Empezando mantenimiento del sistema\n"

yum update
yum -y upgrade

yum -y autoremove

echo -e "\n$(date "+%T") \t Mantenimiento terminado"