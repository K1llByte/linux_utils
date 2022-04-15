#!/bin/bash

cpcp() {
    mkdir -p $(basename $2)
    cp $1 $2
}
