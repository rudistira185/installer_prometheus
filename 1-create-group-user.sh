#!/bin/bash

#create group
if getent group prometheus > /dev/null; then
   echo "(INFO) groupd exist"
else
  if groupadd --system prometheus; then
    echo "group add success prometheus"
else
   echo "group failed create"
   exit 1
  fi
fi

#create user
if id prometheus > /dev/null 2>&1; then
  echo "(info) user prometheus exist"
else
   if useradd --system -s /sbin/nologin -g prometheus prometheus; then
   echo "(INFO) user prometheus sucess create"
   else
    echo "failed crete user"
    exit 1
  fi
fi
