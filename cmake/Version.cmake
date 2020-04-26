execute_process(COMMAND git rev-parse --symbolic-full-name --abbrev-ref HEAD
  WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
  OUTPUT_VARIABLE branch
  ERROR_QUIET
  OUTPUT_STRIP_TRAILING_WHITESPACE)
string(COMPARE EQUAL "${branch}" "" empty_string)
if(empty_string)
  set(branch "unknown")
endif(empty_string)
set(GIT_VERSION "${branch}")

execute_process(COMMAND git rev-parse --short HEAD
  WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
  OUTPUT_VARIABLE sha1
  OUTPUT_STRIP_TRAILING_WHITESPACE)
string(COMPARE EQUAL "${sha1}" "" empty_string)
if(empty_string)
  set(sha1 "unknown")
endif(empty_string)
set(GIT_VERSION "${GIT_VERSION}@${sha1}")

execute_process(COMMAND git status -s
  WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
  OUTPUT_VARIABLE dirty
  ERROR_QUIET
  OUTPUT_STRIP_TRAILING_WHITESPACE)
string(COMPARE NOTEQUAL "${dirty}" "" empty_string)
if(empty_string)
  set(GIT_VERSION "${GIT_VERSION}-dirty")
endif(empty_string)
  
