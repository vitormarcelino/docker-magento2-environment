#!/bin/bash
TAG="vitormarcelino/magento2-environment:latest"
docker build -t $TAG .
# docker push $TAG