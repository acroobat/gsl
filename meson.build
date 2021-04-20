project('mpv-moonlight', 'c')
dep = dependency('mpv')

project_source_files = [
  'src/main.c'
]

extra_args = ['-shared', '-fPIC']

library(meson.project_name(), project_source_files, dependencies : dep)
