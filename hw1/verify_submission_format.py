#!/usr/bin/env python3
import argparse
import zipfile
import tarfile
import os
import pathlib

dir_path = os.path.dirname(os.path.realpath(__file__))

def main():
    parser = argparse.ArgumentParser(
                        description="Hepler to verify the file structure of your zip/tgz file")
    parser.add_argument("target_file", type=argparse.FileType("rb"))
    args = parser.parse_args()
    filelist = read_file_list(args.target_file)
    top_dirname = get_top_dirname(filelist)
    standard_list, not_include_list = read_standart_list(os.path.join(dir_path, "filelist_hw1.txt"))
    compare_file_structure(filelist, standard_list, top_dirname)
    compare_file_structure(filelist, not_include_list, top_dirname, False)
    print("Verifying Complete.  Please ensure there are no error(s) printed.")

def compare_file_structure(filelist, standard_list, top_dir, include=True):
    for filename in standard_list:
        required = os.path.join(top_dir, filename)
        if include:
            if os.path.normpath(required) not in filelist:
                print("[Error] {} not found!".format(filename)) 
        else:
            if os.path.normpath(required) in filelist:
                print("[Error] {} exists! Please delete it!".format(filename)) 



def get_top_dirname(filelist):
    top_level_names = set()
    top_dir = None
    for name in filelist:
        pp = pathlib.PurePath(name)
        if len(pp.parts) > 0:
            top_level = pp.parts[0] 
            top_level_names.add(top_level)
    if "__MACOSX" in top_level_names:
        top_level_names.remove("__MACOSX")
    if(len(top_level_names)==1):
        top_dir = top_level_names.pop()
    else:
        print("[Error] Multiple top level dir! Only one is allowed (any name)")
        exit(1)
    return top_dir

def read_standart_list(filename):
    standard_list = []
    not_include_list = []
    fd = open(filename, mode="r")
    lines = fd.readlines()
    section = 0
    for line in lines:
        if len(line.strip()) == 0:
            break
        if "===" in line:
            section = 1
        if section == 0:
            standard_list.append(line.strip())
        else:
            not_include_list.append(line.strip())
    fd.close()
    return standard_list, not_include_list

def read_file_list(target_file):
    filename = target_file.name
    if filename.endswith(".zip"):
        try:
            zf = zipfile.ZipFile(filename)
        except zipfile.BadZipFile:
            print("Invalid zip file! Exiting...")
            exit(1)
        namelist = zf.namelist()
    elif filename.endswith(".tar.gz") or filename.endswith(".tgz"):
        try:
            tf = tarfile.open(filename)
        except tarfile.ReadError:
            print('Invalid tgz file! Exiting...')
            exit(1)
        namelist = tf.getnames()
    else:
        print("Not zip/tgz file specified. Exiting...")
        exit(1)
    namelist = [os.path.normpath(x) for x in namelist]
    return namelist

if __name__ == "__main__":
    main()
