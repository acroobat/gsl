os.execute("mkdir srctest")
os.execute("sed 's/~/*/g' src/client.c > srctest/client.c")
os.execute("sed 's/~/*/g' src/parsexml.c > srctest/parsexml.c")
os.execute("sed 's/~/*/g' src/docurl.c > srctest/docurl.c")
os.execute("sed 's/~/*/g' src/mkcert.c > srctest/mkcert.c")
os.execute("sed 's/~/*/g' src/client.h > srctest/client.h")
os.execute("sed 's/~/*/g' src/parsexml.h > srctest/parsexml.h")
os.execute("sed 's/~/*/g' src/docurl.h > srctest/docurl.h")
os.execute("sed 's/~/*/g' src/mkcert.h > srctest/mkcert.h")
os.execute("sed 's/~/*/g' src/errorlist.h > srctest/errorlist.h")


os.execute("sed -i 's/server_info_appversion/serverInfoAppVersion/g' -i srctest/client.c && sed 's/server_info_appversion/serverInfoAppVersion/g' -i srctest/client.c")
os.execute("sed 's/_openssl_no_engine/OPENSSL_NO_ENGINE/g' -i srctest/mkcert.c")


os.execute("sed -i srctest/parsexml.c 's/((struct/(struct/g'")
os.execute("sed -i srctest/parsexml.c 's/)) ~/*)  /g'")
os.execute("sed -i srctest/client.c 's/)) ~/*)  /g'")
os.execute("sed -i srctest/client.c 's/((char/(char/g'")
os.execute("sed -i srctest/client.c 's/)) &/*) &/g'")

workspace "mainspace"
configurations { "liblight" }

project "light"
kind "SharedLib"
language "C"
targetdir "%{cfg.buildcfg}"
files { "srctest/**.h", "srctest/**.c" }
--includedirs "moonlight-common-c"

local ver

ver = "0.1-prealpha" 

print("liblight", ver)
print('"~" - pointer sign')
