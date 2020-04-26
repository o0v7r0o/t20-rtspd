if(CROSS)
  string(REGEX REPLACE "-$" "" CROSS "${CROSS}")

  # T20L MIPS
  set(CMAKE_SYSTEM_NAME Linux)
  set(CMAKE_C_COMPILER "${CROSS}-gcc")
  set(CMAKE_CXX_COMPILER "${CROSS}-g++")
  set(CMAKE_STRIP "${CROSS}-strip")

  set(C_FLAGS "-O2 -Wall -march=mips32r2 $ENV{CFLAGS}")
  set(C_DEFS "-DSOCKLEN_T=socklen_t -D_LARGEFILE_SOURCE=1 -D_FILE_OFFSET_BITS=64 -DLOCALE_NOT_USED")

  set(CMAKE_C_FLAGS "${C_FLAGS}")
  set(CMAKE_CXX_FLAGS "${C_FLAGS}")

  set (CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS}")
  set (CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS} -g")

  set (CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS}")
  set (CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} -g")

  # Supress '-rdynamic' linker option
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--no-export-dynamic")

  add_definitions(${C_DEFS})
endif(CROSS)

