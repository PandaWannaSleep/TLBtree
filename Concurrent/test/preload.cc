#include <iostream>
#include <fstream>
#include <cstdint>
#include <cstdlib>
#include <vector>
#include <omp.h>

#include "tlbtree.h"

using std::cout;
using std::endl;
using std::ifstream;

typedef double mytime_t;

_key_t *keys;

template <typename BTreeType>
void preload(BTreeType &tree, int64_t load_size, ifstream & fin, int thread_cnt) {
    #pragma omp parallel num_threads(thread_cnt)
    {
        #pragma omp for schedule(static)
        for(int64_t i = 0; i < load_size; i++) {
            _key_t key = keys[i];
            tree.insert((_key_t)key, (uint64_t)key);
            // std::cout <<i<< " Thread: " << std::this_thread::get_id() <<" key："<<key<< std::endl;
        }
    }
    return ;
}
// template <typename BTreeType>
// void preload(BTreeType &tree, int64_t l, int64_t r) {
    
//     for(int64_t i = l; i <= r; i++) {
//         if(i==26)
//             cout<<"1"<<endl;
//         _key_t key = keys[i];
//         tree.insert((_key_t)key, (uint64_t)key);
//         std::cout << "Thread: " << std::this_thread::get_id() <<" key："<<key<< std::endl;
//     }
//     cout<<l<<" "<<r<<endl;
//     return ;
// }

int main(int argc, char ** argv) {
    int num_threads = 4;

    if(argc > 1 && atoi(argv[1]) > 0) {
        num_threads = atoi(argv[1]);
    }
    // open the data file
    std::string filename = "dataset.dat";
    std::ifstream fin(filename.c_str(), std::ios::binary);
    if(!fin) {
        cout << "File not exists or Open error\n";
        exit(-1);
    }

    // read all the key into vector keys
    keys = new _key_t[sizeof(_key_t) * LOADSCALE * MILLION];
    fin.read((char *)keys, sizeof(_key_t) * LOADSCALE * MILLION);
    
    cout << "tlbtree" << endl;
    TLBtree tree("/mnt/pmem/tlbtree.pool");
    double start = seconds();

    preload(tree, LOADSCALE * MILLION, fin, num_threads);
    // std::thread *threads[num_threads];
    // int64_t step = LOADSCALE * MILLION / num_threads;
    // int64_t l,r = -1;
    // for(size_t i = 0; i < num_threads; i++){
    //     l = r + 1;
    //     r = (i==num_threads-1 ? LOADSCALE * MILLION : (i+1) * step) - 1;
    //     threads[i] = new std::thread(preload<TLBtree>, std::ref(tree), l, r);
    //     // threads[i] = new std::thread(preload<TLBtree>, tree, LOADSCALE * MILLION, fin, num_threads);
    // }
    // for(size_t i = 0; i < num_threads; i++){
    //     threads[i]->join();
    //     delete threads[i];
    // }


    double time = seconds() - start;
    // std::cout<<time<<std::endl;
    std::cout<<"preload time:"<<time<<std::endl;

    delete keys;
    fin.close();

    return 0;
}
/*  
    Copyright(c) 2020 Luo Yongping. THIS SOFTWARE COMES WITH NO WARRANTIES, 
    USE AT YOUR OWN RISK!
*/
