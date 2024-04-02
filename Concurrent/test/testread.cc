#include <iostream>
#include <fstream>
#include <cstdint>
#include <cstdlib>
#include <vector>
#include <random>
#include <algorithm>
#include <omp.h>

#include "tlbtree.h"

using std::cout;
using std::endl;
using std::ifstream;
using std::string;

template<typename BtreeType>
void run_test() {
    // construct a Btree
    BtreeType tree("/mnt/pmem/tlbtree.pool");
    uint64_t key = 8657589741479328579;
    auto val = tree.lookup(key);
    assert(val != 0);
  
}


int main(int argc, char ** argv) {
    
    run_test<TLBtree>();


    return 0;
}