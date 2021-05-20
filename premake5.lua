--os.execute("sed -i srctest/docurl.c 's/CURLCODE/CURLcode/g'")

workspace "mainspace"
configurations { "liblight" }

project "light"
kind "SharedLib"
language "C"
targetdir "%{cfg.buildcfg}"
files { "src/**.h", "src/**.c" }
--includedirs "moonlight-common-c"

local ver

ver = "0.1-prealpha"

print("liblight", ver)
