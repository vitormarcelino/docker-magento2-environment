#!/bin/bash
TAG="vitormarcelino/magento2-environment:8.1"
docker build -t $TAG .
docker push $TAG
