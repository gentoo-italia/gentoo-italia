#!/usr/bin/env python
import re, json, urllib3, os, sys, glob, shutil

#TODO shitty but I love colors :D
class bcolors:
    PURPLE = '\033[95m'
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def strip_prefix(s, prefix):
    if s.startswith(prefix):
        return s[len(prefix):]
    return str(s)

def get_github_release(user, name, release='latest'):
    try:
        urllib3.disable_warnings()
        user_agent = {'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.76 Safari/537.36'}
        http = urllib3.PoolManager(headers=user_agent)
        r = http.request('GET', 'https://api.github.com/repos/%s/%s/releases/%s' % ( str(user), str(name), str(release) ))
        return json.loads(r.data.decode('utf-8'))
    except Exception as e:
        print(e)
        return None

def parse_github_json(data):
    try:
        #url = data['tarball_url']
        #author = data['author']['login']
        #prefix = "https://github.com/" + user + "/"
        #name = strip_prefix(data['html_url'], prefix)
        #name = name.replace("/releases/tag/", "-")
        #name = name[:name.rindex('-')]
        version = strip_prefix(data['tag_name'], 'v')
        #return url, author, name, version
        return version
    except Exception as e:
        print(bcolors.RED + "error parsing json from github" + bcolors.ENDC)
        pass
    return None

def print_ebuild(user, name, e_version, g_version=None):
    print(bcolors.YELLOW + "local  : %s-%s" % (name, e_version) + bcolors.ENDC)
    if g_version:
        print( bcolors.PURPLE + "github : %s/%s-%s" % (user, name, g_version) + bcolors.ENDC)

def parse_ebuild_name(path):
    basename = os.path.basename(path)
    name = os.path.splitext(basename)[0]
    name = re.sub('-r[0-9]+$','', name)
    version = name[name.rindex('-')+1:]
    name = name[:name.rindex('-')]
    return name, version

def parse_ebuild_content(path):
    with open(path, 'r') as file:
        s = file.read()
        if 'github.com' in s:
            pattern = r'SRC_URI\=\"(.+)\"'
            m = re.search(pattern, s)
            if m:
                pattern = r'https?:\/\/github.com\/([a-zA-z0-9${}]+)\/([a-zA-z0-9${}]+)'
                m = re.match(pattern, m.group(1))
                if m:
                    return m.group(1), m.group(2)
    return None

def ask(prompt, error_msg = 'try again', valid=['y','n','yes','no']):
        while True:
            value = input(prompt + " ")
            ret = value.strip().lower()[0]
            if ret and ret in valid:
                return ret
            else:
                print(error_msg, file=sys.stderr)

def check_ebuild(path):
    try:
        name, e_version = parse_ebuild_name(path)
        e_user, e_name = parse_ebuild_content(path)
        if e_user == "${PN}":
            e_user = name
        if e_name == "${PN}":
            e_name = name

        data = get_github_release(e_user, e_name)
        g_version = parse_github_json(data)
        print_ebuild(e_user, e_name, e_version, g_version)

        if g_version and (str(e_version) < str(g_version)):
            if ask("Do you want to update this ebuild? [y/N]") == 'y':
                print(bcolors.BLUE + "updating ebuild ... " + e_version + " => " + g_version + bcolors.ENDC)
                npath = path.replace(e_version, g_version)
                shutil.copy(path,npath)
                if ask("Do you want do delete the old one? :O [y/N]") == 'y':
                    os.remove(path)
    except Exception as e:
        pass

if __name__ == "__main__":
    for root, path, files in os.walk('.', topdown=True, followlinks=False):
        path[:] = list(filter(lambda x: not x in [".git", "profiles", "metadata", "files", "scripts"], path))
        if path and root != ".":
            for dir in path:
                realpath = os.path.join(root, dir)
                fpath = list(filter(lambda x: not x.endswith("9999.ebuild"), glob.glob(os.path.join(realpath, "*.ebuild"))))
                if fpath:
                    for e in fpath:
                        check_ebuild(e)

