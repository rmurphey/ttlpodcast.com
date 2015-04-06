#!/bin/bash
harp compile
. ../aws-credentials
aws s3 cp www/ s3://ttlpodcast.com/ --recursive
