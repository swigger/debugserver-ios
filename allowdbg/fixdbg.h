#pragma once
uint32_t get_csflags(int pid);
uint32_t fixup_debug(int pid);

uint64_t proc_find(int pid);
uint32_t rk32(uint64_t kaddr);
void wk32(uint64_t kaddr, uint32_t v);
