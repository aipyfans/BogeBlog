#!/bin/bash

#rm -rf docs && hexo clean && hexo deploy && mv public docs && git add -A && git commit -m "TO-DO" && git push origin master

rm -rf docs && hexo clean && hexo generate && mv public docs && git add -A && git commit -m "$1" && git push origin master
