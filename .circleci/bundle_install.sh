#!/bin/bash -xe

bundle install --jobs=4 --retry=3 --path vendor/bundle
bundle clean
