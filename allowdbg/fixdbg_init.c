#include <CoreFoundation/CoreFoundation.h>
#include <mach/mach.h>
#include <sys/stat.h>
#include "kmem.h"
#include "kern_utils.h"

#define DEBUGLOG(fmt, args...) fprintf(stderr, fmt "\n", ##args);

CFDictionaryRef load_map(const char * fn)
{
	int d = open(fn, O_RDONLY);
	if (d<0) return 0;
	struct stat st;
	fstat(d, &st);

	void * m = malloc(st.st_size);
	if (m)
		read(d, m, st.st_size);
	close(d);
	if (!m) return 0;

	CFDataRef r = CFDataCreate(kCFAllocatorDefault, (const uint8_t*) m, st.st_size);
	CFPropertyListRef plist = CFPropertyListCreateWithData(kCFAllocatorDefault, r, 0, 0, 0);
	CFRelease(r);
	free(m);

	if (CFGetTypeID(plist) == CFDictionaryGetTypeID())
	{
		return (CFDictionaryRef)plist;
	}
	CFRelease(plist);
	return 0;
}

static uint64_t ull_val(CFDictionaryRef dict, CFStringRef key)
{
	CFStringRef tmps = (CFStringRef) CFDictionaryGetValue(dict, key);
	const char * p = (const char *)CFStringGetCStringPtr(tmps, kCFStringEncodingUTF8);
	uint64_t val = strtoull(p, 0LL, 16);
	return val;
}
#define _(x) ull_val(dict, CFSTR(x))
static int init_offsets()
{
	CFDictionaryRef dict = 	load_map("/jb/offsets.plist");
	if (!dict)
	{
		fprintf(stderr, "unable to load offsets!\n");
		return -1;
	}
	kernel_base             = _("KernelBase");
	kernel_slide            = _("KernelSlide");
	offset_kernel_task      = _("KernelTask");
	offset_zonemap          = _("ZoneMapOffset");
	offset_add_ret_gadget   = _("AddRetGadget");
	offset_osboolean_true   = _("OSBooleanTrue");
	offset_osboolean_false  = _("OSBooleanFalse");
	offset_osunserializexml = _("OSUnserializeXML");
	offset_smalloc          = _("Smalloc");
	CFRelease(dict);
	return kernel_base? 0: -1;
}


__attribute__((constructor))
static int init_port()
{
    mach_port_t tfp0 = MACH_PORT_NULL;
    kern_return_t err;

    err = host_get_special_port(mach_host_self(), 0, 4, &tfp0);
    if (!tfp0)
	{
		DEBUGLOG("unable to retrieve tfp0 %s(%d)", mach_error_string(err), err);
		return -1;
	}
	DEBUGLOG("got tfp0!");
	set_tfp0(tfp0);

    struct task_dyld_info dyld_info = { 0 };
    mach_msg_type_number_t count = TASK_DYLD_INFO_COUNT;
    if (task_info(tfp0, TASK_DYLD_INFO, (task_info_t)&dyld_info, &count) != KERN_SUCCESS ||
        (kernel_base = dyld_info.all_image_info_addr) == 0) {
		DEBUGLOG("unable to find kernel base");
        return -3;
    }
    kernel_slide            = kernel_base - 0xFFFFFFF007004000;
    DEBUGLOG("kern base: %llx, slide: %llx", kernel_base, kernel_slide);
	return init_offsets();
}
