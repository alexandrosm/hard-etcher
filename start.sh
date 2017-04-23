#!/bin/bash

rm /tmp/.X0-lock &>/dev/null || true
startx etcher-electron
