# project(TLBtree)

# cmake_minimum_required(VERSION 3.16)

# add_compile_options(-mclwb -fmax-errors=5 -fopenmp)
# add_compile_options(-O3)
# link_libraries(/usr/local/lib/libpmemobj.so.1)
# add_link_options(-pthread -fopenmp)

# include_directories(include)

# add_subdirectory(src)
# add_subdirectory(test)


project(TLBtree)

cmake_minimum_required(VERSION 3.16)

add_compile_options(-mclwb -fmax-errors=5 -fopenmp)
add_compile_options(-O0)

# 添加调试信息，测试性能时删掉
set(CMAKE_BUILD_TYPE "DEBUG")
add_definitions("-g")

link_libraries(/usr/local/lib/pmdk_debug/libpmemobj.so.1)
add_link_options(-pthread -fopenmp)

include_directories(include)

add_subdirectory(src)
add_subdirectory(test)