#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh ${cluster_name} --kubelet-extra-args --node-labels=lifecycle=Ec2Spot