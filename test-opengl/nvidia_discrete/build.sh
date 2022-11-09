#!/usr/bin/env bash

SOURCE_IMAGE=ubuntu:jammy

docker build --build-arg from=$SOURCE_IMAGE -t glvnd-x:nvidia_discrete .


