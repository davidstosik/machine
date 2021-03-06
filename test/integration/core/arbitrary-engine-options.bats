#!/usr/bin/env bats

load ${BASE_TEST_DIR}/helpers.bash

@test "$DRIVER: create with arbitrary engine option" {
  run machine create -d $DRIVER \
    --engine-opt log-driver=none \
    $NAME
  echo ${output}
  [ $status -eq 0 ]
}

@test "$DRIVER: check created engine option (log driver)" {
  docker $(machine config $NAME) run --name nolog busybox echo this should not be logged
  run docker $(machine config $NAME) logs nolog
  echo ${output}
  [ $status -eq 0 ]
  [[ ${lines[0]} =~ "no log driver named 'none' is registered" ]]
}
