#!/bin/bash
TAG="vitormarcelino/magento2-environment:7.4"
docker build -t $TAG .
docker push $TAG
