workspace "mainspace"
   configurations { "build" }

project "lightplug"
   kind "SharedLib"
   language "C"
   targetdir "%{cfg.buildcfg}"

   files { "src/**.h", "src/**.c" }
