#!/usr/bin/env bash
jkopt1="--sessionTimeout=1440"
jkopt2="--sessionEviction=86400"
jvopt1="-Duser.timezone=Asia/Seoul"
jvopt2="-Dcasc.jenkins.config=https://raw.githubusercontent.com/beomtaek/cicd_samplecode/4b32b6f7a3ab3cb11fa02847fa0aca6b7f2309fc/jenkins-config.yaml"
jvopt3="-Dhudson.model.DownloadService.noSignatureCheck=true"

helm install jenkins edu/jenkins \
--set persistence.existingClaim=jenkins \
--set master.adminPassword=admin \
--set master.nodeSelector."kubernetes\.io/hostname"=master \
--set master.tolerations[0].key=node-role.kubernetes.io/master \
--set master.tolerations[0].effect=NoSchedule \
--set master.tolerations[0].operator=Exists \
--set master.runAsUser=1000 \
--set master.runAsGroup=1000 \
--set master.tag=2.249.3-lts-centos7 \
--set master.serviceType=LoadBalancer \
--set master.servicePort=80 \
--set master.jenkinsOpts="$jkopt1 $jkopt2" \
--set master.javaOpts="$jvopt1 $jvopt2 $jvopt3"
