-- premake5.lua
workspace "Premake"
   configurations { "Debug", "Release" }

project "mpv-moonlight"
   kind "SharedLib"
   language "C"
   targetdir "%{cfg.buildcfg}"

   files { "plug/src/**.h", "plug/src/**.c" }

   filter "configurations:Debug"
      defines { "DEBUG" }
--      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"
