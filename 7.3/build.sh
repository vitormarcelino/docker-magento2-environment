#!/bin/bash
TAG="vitormarcelino/magento2-environment:7.3"
docker build -t $TAG .
docker push $TAG
