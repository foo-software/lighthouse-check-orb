#!/bin/bash

circleci config pack src > orb.yml
circleci orb publish orb.yml foo-software/lighthouse-check@dev:alpha
rm -rf orb.yml
