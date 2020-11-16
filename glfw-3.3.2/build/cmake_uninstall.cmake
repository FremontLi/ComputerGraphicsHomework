
if (NOT EXISTS "E:/大三上/5计算机图形学/实验/glfw-3.3.2/build/install_manifest.txt")
  message(FATAL_ERROR "Cannot find install manifest: \"E:/大三上/5计算机图形学/实验/glfw-3.3.2/build/install_manifest.txt\"")
endif()

file(READ "E:/大三上/5计算机图形学/实验/glfw-3.3.2/build/install_manifest.txt" files)
string(REGEX REPLACE "\n" ";" files "${files}")

foreach (file ${files})
  message(STATUS "Uninstalling \"$ENV{DESTDIR}${file}\"")
  if (EXISTS "$ENV{DESTDIR}${file}")
    exec_program("E:/大三上/5计算机图形学/实验/cmake-3.19.0-rc2-win32-x86/bin/cmake.exe" ARGS "-E remove \"$ENV{DESTDIR}${file}\""
                 OUTPUT_VARIABLE rm_out
                 RETURN_VALUE rm_retval)
    if (NOT "${rm_retval}" STREQUAL 0)
      MESSAGE(FATAL_ERROR "Problem when removing \"$ENV{DESTDIR}${file}\"")
    endif()
  elseif (IS_SYMLINK "$ENV{DESTDIR}${file}")
    EXEC_PROGRAM("E:/大三上/5计算机图形学/实验/cmake-3.19.0-rc2-win32-x86/bin/cmake.exe" ARGS "-E remove \"$ENV{DESTDIR}${file}\""
                 OUTPUT_VARIABLE rm_out
                 RETURN_VALUE rm_retval)
    if (NOT "${rm_retval}" STREQUAL 0)
      message(FATAL_ERROR "Problem when removing symlink \"$ENV{DESTDIR}${file}\"")
    endif()
  else()
    message(STATUS "File \"$ENV{DESTDIR}${file}\" does not exist.")
  endif()
endforeach()

