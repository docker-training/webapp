#!/bin/bash -e

# Declare variable 
AWS_ACCOUNT_ID=436350383194
EB_REGION=us-east-1
DOCKER_REPO=ml-app


# the registry should have been created already
# you could just paste a given url from AWS but I'm
# parameterising it to make it more obvious how its constructed
REGISTRY_URL=${AWS_ACCOUNT_ID}.dkr.ecr.${EB_REGION}.amazonaws.com

# this is most likely namespaced repo name like myorg/veryimportantimage
SOURCE_IMAGE="${DOCKER_REPO}"

# using it as there will be 2 versions published
TARGET_IMAGE="${REGISTRY_URL}/${DOCKER_REPO}"

# lets make sure we always have access to latest image
TARGET_IMAGE_LATEST="${TARGET_IMAGE}:latest"
TIMESTAMP=$(date '+%Y%m%d%H%M%S')

# using datetime as part of a version for versioned image
VERSION="${TIMESTAMP}-${TRAVIS_COMMIT}"

# using specific version as well
# it is useful if you want to reference this particular version
# in additional commands like deployment of new Elasticbeanstalk version
TARGET_IMAGE_VERSIONED="${TARGET_IMAGE}:${VERSION}"

# making sure correct region is set
aws configure set default.region ${EB_REGION}

# Push image to ECR
###################

# I'm speculating it obtains temporary access token
# it expects aws access key and secret set
# in environmental vars
eval $(aws ecr get-login --region us-east-1)

# update latest version
docker tag ${SOURCE_IMAGE} ${TARGET_IMAGE_LATEST}
docker push ${TARGET_IMAGE_LATEST}

# push new version
docker tag ${SOURCE_IMAGE} ${TARGET_IMAGE_VERSIONED}
docker push ${TARGET_IMAGE_VERSIONED}