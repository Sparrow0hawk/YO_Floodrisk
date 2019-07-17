#!/bin/bash

echo 'Lets make you a good conda env'
echo 'Hope you are in the same directory as the requirements.txt!'

conda create --name yoflood --file requirements.txt
