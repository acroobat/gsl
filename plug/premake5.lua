os.execute("mkdir srctest && sed 's/~/*/g' src/main.c > srctest/main.c")
--os.execute("sed -i srctest/main.c 's/samlerate/sampleRate/g'")

workspace "mainspace"
   configurations { "build" }

project "lightplug"
   kind "SharedLib"
   language "C"
   targetdir "%{cfg.buildcfg}"

   files { "srctest/**.h", "srctest/**.c" }
--   includedirs "liblight"
