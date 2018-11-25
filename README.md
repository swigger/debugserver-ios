## install
    git clone http://llvm.org/git/lldb.git
    cd lldb/tools/debugserver/
    git clone https://github.com/swigger/debugserver-ios.git ios
    cd ios
    make

## depends
aarch64 tools set for ios.

## usage
```
	dbgsrv64 OPTIONS ...
OPTIONS:
    -e envkey=val :  set environment.
    -g            :  set debug
    -p            :  run in platform mode.
    -D            :  disable ASLR
    -v            : verbose
    -f 0xffffff   : set log mask  
    -a pid        : attach to pid
    -l log_file.  : enable log to file. can be stdout/stderr
ex:
    dbgsrv64 -v -g -f 0xffffffff -l stderr :1234 /Applications/Cydia.app
```
