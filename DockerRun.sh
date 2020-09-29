#!/bin/bash
docker rm $(docker ps -q -f status=exited)
docker run -it --network host --name smcroute georgenicoll/smcroute
