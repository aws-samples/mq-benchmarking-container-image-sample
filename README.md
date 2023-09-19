# Amazon MQ ActiveMQ: Container Image Guide

## Overview

This container repository provides you with flexibility to create your image for benchmarking both on desktop and also on Amazon ECR. You can use your built/created image as `container_repo_url` [here](https://github.com/moatiq27/amazonmq-benchmarking-sample/). 

This repository applies to only open wire protocol. If you need to use other protocols and clients, kindly refer to [Amazon MQ workshop](https://github.com/aws-samples/amazon-mq-workshop) 

## Prerequisites

* Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
* If you are pushing the image to ECR, make sure the assigned role/user has the necessary [permissions](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-push.html) 

## How to use the Container Image

### To build and run image locally

```
docker build -t <your repository name>:<tag> .
docker run <specifiy your docker run option>

```
For Example:

```
docker run --rm -it --entrypoint /bin/bash <your repository name>:<tag>

```
### Push image to ECR

Kindly refer to [ECS documentation]( https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-container-image.html#create-container-image-push-ecr).