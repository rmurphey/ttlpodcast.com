#!/bin/bash

# generate the static assets
harp compile

# use personal aws credentials
. ../aws-credentials

# sync everything except files that should have a short ttl
aws s3 sync www/ s3://ttlpodcast.com --cache-control="max-age=1576800000" \
  --exclude="index.html" \
  --exclude="rss.xml"

# sync files that should have a short ttl
aws s3 sync www/index.html s3://ttlpodcast.com/index.html --cache-control="max-age=600" \
  --exclude="*" \
  --include="index.html" \
  --include="rss.xml"
