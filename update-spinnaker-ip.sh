#!/bin/bash
 
hal config security ui  edit --override-base-url http://13.233.88.205:9000 --debug
hal config security api edit --override-base-url http://13.233.88.205:8084 --debug

# applying hal configurations.
# installing spinnaker.
sudo hal deploy apply --debug
sudo systemctl daemon-reload

# connecting to hal dek.
sudo hal deploy connect
