def FlagsForFile(filename, **kwargs):

  flags = [
    '-Wall',
    '-Wextra',
    '-Werror'
    '-pedantic',
  ]

  return {
    'flags':    flags,
    'do_cache': True
  }
