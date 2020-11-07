#include <CoreFoundation/CoreFoundation.h>
#include <sched.h>
#include <sys/stat.h>
#include <sys/param.h>

#include "kern_utils.h"
#include "kmem.h"
#include "ios_offsets.h"


uint64_t kernel_base;
uint64_t kernel_slide;

uint64_t offset_kernel_task;
uint64_t offset_zonemap;
uint64_t offset_add_ret_gadget;
uint64_t offset_osboolean_true;
uint64_t offset_osboolean_false;
uint64_t offset_osunserializexml;
uint64_t offset_smalloc;

// Please call `proc_release` after you are finished with your proc!
uint64_t proc_find(int pid)
{
	unsigned int off2; // w8
	unsigned int loff; // [xsp+4h] [xbp-2Ch] MAPDST
	uint64_t kern_task; // [xsp+8h] [xbp-28h]
	uint64_t ptr; // [xsp+18h] [xbp-18h]

	kern_task = rk64(offset_kernel_task);
	if ( kCFCoreFoundationVersionNumber < 1443.0 )
	{
		loff = 864;
	}
	else if ( kCFCoreFoundationVersionNumber < 1535.12 )
	{
		loff = 872;
	}
	else
	{
		loff = 856;
	}
	for ( ptr = rk64(kern_task + loff); ptr; ptr = rk64(ptr + 8) )
	{
		if ( kCFCoreFoundationVersionNumber < 1535.12 )
			off2 = 16;
		else
			off2 = 96;
		if ( (unsigned int)rk32(ptr + off2) == pid )
			return ptr;
	}
	return 0LL;
}

uint64_t our_task_addr_(void)
{
	int pid; // w0
	uint64_t proc; // x0
	unsigned int task_off; // w8

	pid = getpid();
	proc = proc_find(pid);
	if ( kCFCoreFoundationVersionNumber < 1535.12 )
		task_off = 24;
	else
		task_off = 16;
	return rk64(proc + task_off);
}

uint64_t our_task_addr(void)
{
	static uint64_t ot = 0;
	if (!ot)
		ot = our_task_addr_();
	return ot;
}

uint64_t find_port(mach_port_name_t port) {
    uint64_t task_addr = our_task_addr();

    uint64_t itk_space = rk64(task_addr + offsetof_itk_space);

    uint64_t is_table = rk64(itk_space + offsetof_ipc_space_is_table);

    uint32_t port_index = port >> 8;
    const int sizeof_ipc_entry_t = 0x18;

    return rk64(is_table + (port_index * sizeof_ipc_entry_t));
}


uint32_t get_csflags(int pid)
{
	uint64_t proc = proc_find(pid);
	if (proc == 0)
	{
		fprintf(stderr, "unable to find proc for pid %d\n", pid);
		return 0;
	}
    uint32_t csflags = rk32(proc + offsetof_p_csflags);
	return csflags;
}

uint32_t fixup_debug(int pid)
{
	if (offset_kernel_task == 0) return 0;
	uint64_t proc = proc_find(pid);
	if (proc == 0)
	{
		fprintf(stderr, "unable to find proc for pid %d\n", pid);
		return 0;
	}
	uint32_t csflags = rk32(proc + offsetof_p_csflags);
	//NOTE: CS_REQUIRE_LV should not be removed, otherwise all apps failed to start, have to reboot system.
	uint32_t remove = CS_HARD | CS_KILL;
	csflags |= CS_GET_TASK_ALLOW;
	csflags &= ~remove;
    wk32(proc + offsetof_p_csflags, csflags);
	fprintf(stderr, "\x1b[1;31mSucc fixed pid %d %x\x1b[0m\n", pid, csflags);
	return csflags;
}
