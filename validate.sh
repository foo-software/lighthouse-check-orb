#!/bin/bash

circleci config pack src > orb.yml
circleci orb validate orb.yml
rm -rf orb.yml
