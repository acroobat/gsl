--os.execute("mkdir srctest")
os.execute("sed 's/~/*/g' src/base.c > srctest/base.c")
os.execute("sed 's/~/*/g' src/parsexml.c > srctest/parsexml.c")
os.execute("sed 's/~/*/g' src/docurl.c > srctest/docurl.c")
os.execute("sed 's/~/*/g' src/cryptssl.c > srctest/cryptssl.c")
os.execute("sed 's/~/*/g' src/base.h > srctest/base.h")
os.execute("sed 's/~/*/g' src/parsexml.h > srctest/parsexml.h")
os.execute("sed 's/~/*/g' src/docurl.h > srctest/docurl.h")
os.execute("sed 's/~/*/g' src/cryptssl.h > srctest/cryptssl.h")
os.execute("sed 's/~/*/g' src/errorlist.h > srctest/errorlist.h")

os.execute("sed 's/~|\(.*\)|/(\1*)/' -i srctest/parsexml.c")
os.execute("sed 's/|\([A-z]\)\(.*\)\([A-z1-9]\)|/(\1\2\3)/' -i srctest/parsexml.c")
os.execute("sed 's/~|\(.*\)|/(\1*)/' -i srctest/base.c")
os.execute("sed 's/|\([A-z]\)\(.*\)\([A-z1-9]\)|/(\1\2\3)/' -i srctest/base.c")
os.execute("sed 's/~|\(.*\)|/(\1*)/' -i srctest/cryptssl.c")
os.execute("sed 's/|\([A-z]\)\(.*\)\([A-z1-9]\)|/(\1\2\3)/' -i srctest/cryptssl.c")


os.execute("sed -i 's/server_info_appversion/serverInfoAppVersion/g' -i srctest/base.c && sed 's/server_info_appversion/serverInfoAppVersion/g' -i srctest/base.c")
os.execute("sed 's/_openssl_no_engine/OPENSSL_NO_ENGINE/g' -i srctest/cryptssl.c")



workspace "mainspace"
configurations { "liblight" }

project "light"
kind "SharedLib"
language "C"
targetdir "%{cfg.buildcfg}"
files { "srctest/**.h", "srctest/**.c" }

local ver

ver = "0.3-beta" 

print("liblight", ver)
