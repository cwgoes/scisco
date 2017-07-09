#!/bin/sh

cd /scisco

echo -n "Launching webserver..."

cd www && npm start &
sleep 6

echo " OK"

echo "Head on over to http://localhost:3000 in your web browser (and make sure you exposed that port to the host if you're running Scisco from a Docker image)."

echo -n "Launching consensus layer..."

stack exec scisco &
sleep 3

echo " OK"

echo -n "Launching Tendermint..."

tendermint init
tendermint unsafe_reset_all
tendermint node
