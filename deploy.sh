#!/bin/bash

# generate the static assets
harp compile

# use personal aws credentials, stored outside of the repo
. ../aws-credentials

# images/media should have a long ttl
aws s3 sync www/ s3://ttlpodcast.com --cache-control="max-age=1576800000" \
    --acl="public-read" \
    --exclude="*" \
    --include="*.jpg" \
    --include="*.png" \
    --include="*.mp3"

# everything else should have a short ttl
aws s3 sync www/ s3://ttlpodcast.com --cache-control="max-age=600" \
    --acl="public-read" \
    --exclude="*.jpg" \
    --exclude="*.png" \
    --exclude="*.mp3" \
    --exclude=".DS_Store"
