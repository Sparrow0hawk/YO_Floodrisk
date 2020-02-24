#!/bin/bash

echo 'Lets make you a good conda env'
echo 'Hope you are in the same directory as the environment.yml!'

conda env create -f environment.yml
