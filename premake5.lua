workspace "mainspace"
   configurations { "liblight" }

project "light"
   kind "SharedLib"
   language "C"
   targetdir "%{cfg.buildcfg}"

   files { "src/**.h", "src/**.c" }
   includedirs "moonlight-common-c"
