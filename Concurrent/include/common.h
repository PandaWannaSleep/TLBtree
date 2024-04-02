/*
    Copyright (c) Luo Yongping. THIS SOFTWARE COMES WITH NO WARRANTIES, 
    USE AT YOUR OWN RISK!
*/
#ifndef __COMMON_H__
#define __COMMON_H__

#include <cstdlib>
#include <limits>
#include <cstdint>
#include <sys/stat.h>
#include <typeinfo>

#define LOADSCALE 1

#define KILO 1024
#define MILLION (KILO * KILO)  //KILO * 128
#define CACHE_LINE_SIZE 64

#define DOFLUSH

#ifndef KEYTYPE
    using _key_t = int64_t;
#else
    using _key_t = KEYTYPE;
#endif

const _key_t MAX_KEY = std::numeric_limits<_key_t>::max();
const _key_t MIN_KEY = typeid(_key_t) == typeid(double) || typeid(_key_t) == typeid(float) 
                            ? -1 * MAX_KEY : std::numeric_limits<_key_t>::min();

struct Record {
    _key_t key;
    char * val; 
    Record(_key_t k=MAX_KEY, char * v=NULL) : key(k), val(v) {}
    bool operator < (const Record & other) {
        return key < other.key;
    }
};

enum OperationType {READ = 0, INSERT, UPDATE, DELETE};
enum DatasetType {UNIFORM = 0, NORMAL, LOGNORMAL};

struct QueryType {
    OperationType op;
    int64_t key;
};

struct res_t { // a result type use to pass info when split and search
    bool flag; 
    Record rec;
    res_t(bool f, Record e):flag(f), rec(e) {}
};

#include <sys/time.h>
inline double seconds()
{
  timeval now;
  gettimeofday(&now, NULL);
  return now.tv_sec + now.tv_usec/1000000.0;
}

inline int getRandom() {
    timeval now;
    gettimeofday(&now, NULL);
    return now.tv_usec;
}

inline bool file_exist(const char *pool_path) {
    struct stat buffer;
    return (stat(pool_path, &buffer) == 0);
}

#endif //__COMMON_H__