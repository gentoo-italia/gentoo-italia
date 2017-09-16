#!/usr/bin/env python

import os,sys,glob

for root, path, files in os.walk('.', topdown=True, followlinks=False):
	path[:] = list(filter(lambda x: not x in [".git", "profiles", "metadata", "files", "scripts"], path))
	if path and root != ".":
		for dir in path:
			realpath = os.path.join(root, dir)
			fpath = list(filter(lambda x: not x.endswith("-9999.ebuild"), glob.glob(os.path.join(realpath, "*.ebuild"))))
			if fpath:
				name = map(lambda x: os.path.splitext(os.path.basename(x))[0], fpath)
				for e in name:
					print(e)

