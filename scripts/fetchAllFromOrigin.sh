#!/usr/bin/env python
import subprocess
import os
import glob
import re
import time
import sys
from subprocess import Popen
import pipes
import argparse

LOCAL_REPO_DIRECTORY = '/home/hector/thor/'
ROSBUILD_DIRECTORY = '/home/hector/thor/rosinstall/'

def parse():
    pattern  = ROSBUILD_DIRECTORY+"*.rosinstall"
    for index, script in enumerate(sorted(glob.glob(pattern))):
        with open (script, "r") as myfile:
            data=myfile.read()
        allFolders = re.findall("local-name: \S*", data)   
        
        for i in range(len(allFolders)):
            folders = re.findall("\S*",allFolders[i])            
            local_folder = LOCAL_REPO_DIRECTORY + folders[2].replace(',','').replace(' ','')
            
            if(os.path.isdir(local_folder)):                          
                print "Now processing "+local_folder+" folder...."
                os.system("cd "+local_folder+";git fetch origin +refs/heads/*:refs/heads/* --prune")
                
if __name__ == "__main__":
    parse()
