#!/usr/bin/python
#coding=utf-8
import sys
import os
import fnmatch
import shutil
import string
import hashlib
import zipfile
import re

md5_datas = "MD5CheckList.data"
src_path = "src"
res_path = "res"
config = "src/config.lua"
AppVersionKey = "MiniGames"
ReleaseKey = "R"

def calcVersions(source):
    p = re.compile('name="(\w+)",version=(\d+\.\d+)')
    return p.findall(source)

def md5sum(fname):
    """ 计算文件的MD5值
    """
    def read_chunks(fh):
        fh.seek(0)
        chunk = fh.read(8096)
        while chunk:
            yield chunk
            chunk = fh.read(8096)
        else: #最后要将游标放回文件开头
            fh.seek(0)
    m = hashlib.md5()
    if isinstance(fname, basestring) \
            and os.path.exists(fname):
        with open(fname, "rb") as fh:
            for chunk in read_chunks(fh):
                m.update(chunk)
    #上传的文件缓存 或 已打开的文件流
    elif fname.__class__.__name__ in ["StringIO", "StringO"] \
            or isinstance(fname, file):
        for chunk in read_chunks(fname):
            m.update(chunk)
    else:
        return ""
    return m.hexdigest()

def getReleaseFromConfig():
	release = False
	if os.path.exists(config):
		fp = open(config)
		content=fp.read()
		
		for v in calcVersions(content):
			if v[0]==AppVersionKey:
			    release=v[1]
			    break
		fp.close()
	else:
		print "no this file:" + config
	return release

def comparing(compared_md5_file):
	print "Start comparing..."
	fp = open(compared_md5_file)
	md5_list = fp.readlines()
	global NEW_RELEASE
	NEW_RELEASE = getReleaseFromConfig()
	last_release = md5_list[0]
	if not NEW_RELEASE or last_release[:-1] >= NEW_RELEASE:
		print "Cannot get new release or The releases are the same, stop to compare."
		return False
	basePath = "%s-%s"%(last_release[:-1], NEW_RELEASE)
	#print "basePath:" + basePath
	comparingAllFiles(src_path, md5_list, basePath)
	comparingAllFiles(res_path, md5_list, basePath)
	#如果只更新小游戏，复制config.lua
	if src_path!="src":
	    shutil.copyfile("src/config.lua", "%s/src/config.lua"%(basePath))
	fp.close()
	return basePath

def comparingAllFiles(obj_path, md5_list, basePath):
	count = 0
	new_count = 0
	for parent,dirnames,filenames in os.walk(obj_path):
		for filename in filenames:
			fullPath = os.path.join(parent, filename)
			md5 = md5sum(fullPath) + " %s\n"%(fullPath)
			last_md5 = getMD5ByFileName(md5_list, fullPath)
			if last_md5 and md5 != last_md5:
				print "new:" + md5[:-1]
				print "last:" + last_md5[:-1]
				print "Found different file"
				print fullPath
				diff_path = createDiffPath(basePath, fullPath)
				shutil.copyfile(fullPath, diff_path)
				count += 1
			else:
				if last_md5 == False:
					print "Found new file:" + fullPath
					diff_path = createDiffPath(basePath, fullPath)
					shutil.copyfile(fullPath, diff_path)
					new_count += 1
	print "\ngot %d different files, %d new files in %s\n"%(count, new_count, obj_path)

def getMD5ByFileName(md5_list, filename):
	for md5_line in md5_list:
		if md5_line.find(filename) >= 0:
			return md5_line
	return False

def createDiffPath(basePath, filePath):
	#print "Creating path:" + split_path
	tmp_path = "%s/%s"%(basePath, os.path.dirname(filePath))
	if not os.path.exists(tmp_path):
		os.makedirs(tmp_path)
	return "%s/%s"%(basePath, filePath)

def createMD5CheckList(md5_data_file):
	print "Creating md5 checklist..."
	fp = open(md5_data_file, "w+")
	current_release = getReleaseFromConfig()
	if current_release:
		print current_release
		fp.write(current_release + "\n")
	writingMD5(src_path, fp)
	writingMD5(res_path, fp)
	fp.close()

def writingMD5(path, fp):
	for parent,dirnames,filenames in os.walk(path):
		for filename in filenames:
			fullPath = os.path.join(parent, filename)
			md5 = md5sum(fullPath) + " %s\n"%(fullPath)
			fp.write(md5)

def createNewMD5CheckList(md5_data_file):
	os.remove(md5_data_file)

def coverCopy(src, dstRoot, dir):
	dst = os.path.join(dstRoot, dir)
	#print "dst is " + dst
	if os.path.exists(dst):
		for parent,dirnames,filenames in os.walk(src):
			for dirname in dirnames:
				tmpList = parent.split("\\")
				tmpList[0] = dir
				dstParent = ""
				for v in tmpList:
					dstParent = os.path.join(dstParent, v)
				dst_dir = os.path.join(dstRoot, dstParent, dirname)
				if not os.path.exists(dst_dir):
					src_dir = os.path.join(parent, dirname)
					shutil.copytree(src_dir, dst_dir)
			for filename in filenames:
				tmpList = parent.split("\\")
				tmpList[0] = dir
				dstParent = ""
				for v in tmpList:
					dstParent = os.path.join(dstParent, v)
				src_file = os.path.join(parent, filename)
				dst_file = os.path.join(dstRoot, dstParent, filename)
				shutil.copy(src_file, dst_file)
				#print "filename: " + filename
		tmp_last_release = dir.split("-")[0]
		tmp_NEW_RELEASE = src.split("-")[1]
		new_dir = "%s-%s"%(tmp_last_release, tmp_NEW_RELEASE)
		new_path = os.path.join(dstRoot, new_dir)
		#print "new_path" + new_path
		if not os.path.exists(new_path):
			shutil.copytree(dst, new_path)
		delete_file_folder(dst)
		last_dst_zip = "%s.zip"%(dst)
		delete_file_folder(last_dst_zip)
		zipPath(dstRoot, new_dir)
		#print "new_dir is: " + new_dir
	else:
		shutil.copytree(src, dst)
		zipPath(dstRoot, dir)

def delete_file_folder(src):
	'''delete files and folders'''
	if os.path.isfile(src):
		try:
			os.remove(src)
		except:
			pass
	elif os.path.isdir(src):
		for item in os.listdir(src):
			itemsrc=os.path.join(src,item)
			delete_file_folder(itemsrc)
		try:
			os.rmdir(src)
		except:
			pass

def copy_update_files(update_path):
	if update_path:
		ReleaseDatasPath = "ReleaseDatas"
		NEW_RELEASE.split(".")
		channelPath = os.path.join(ReleaseDatasPath, "Channel%s"%(NEW_RELEASE[len(NEW_RELEASE) - 1]))
		ReleaseDatasPath = channelPath

		if not os.path.exists(ReleaseDatasPath): os.makedirs(ReleaseDatasPath)
		for dir in os.listdir(ReleaseDatasPath):
			#print "dir: " + dir
			#print "update_path: " + update_path
			if update_path == dir: continue
			if dir.find(".zip") < 0:
				coverCopy(update_path, ReleaseDatasPath, dir)
		coverCopy(update_path, ReleaseDatasPath, update_path)
		#os.remove(md5_datas)
		delete_file_folder(update_path)
		createMD5CheckList(md5_datas)

def zipPath(dstRoot, dir):
	os.chdir(dstRoot)
	zipName = "%s%s.zip"%(AppVersionKey,dir)
	srcPath = os.path.join(dir, "src")
	resPath = os.path.join(dir, "res")

	f = zipfile.ZipFile(zipName, 'w', zipfile.ZIP_DEFLATED)

	if os.path.exists(srcPath):
		os.chdir(dir)
		for dirpath, dirnames, filenames in os.walk("src"):
			for filename in filenames:
				f.write(os.path.join(dirpath,filename))
		os.chdir("..")

	if os.path.exists(resPath):
		os.chdir(dir)
		for dirpath, dirnames, filenames in os.walk("res"):
			for filename in filenames:
				f.write(os.path.join(dirpath,filename))
		os.chdir("..")

	f.close()
	#print "sys.path[0] " + sys.path[0]
	os.chdir(sys.path[0])

if __name__ == '__main__':
        if len(sys.argv) == 2:
	    AppVersionKey=sys.argv[1]
	    src_path = "src/%s"%(AppVersionKey)
	    res_path = "res/%s"%(AppVersionKey)
	if os.path.exists(md5_datas):
		update_path = comparing(md5_datas)
		copy_update_files(update_path)
	else:
		createMD5CheckList(md5_datas)


