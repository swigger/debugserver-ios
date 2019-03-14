#include <stdio.h>
#include <CoreFoundation/CoreFoundation.h>

#ifndef FAKE_MOUNT_PATH
#define FAKE_MOUNT_PATH "/mnt/dbgsrv_node"
#endif

void* CFNotificationCenterGetDistributedCenter();

int got_event = 0;

void newsvc_callback(CFNotificationCenterRef center, void *observer, CFNotificationName name,
					 const void *object, CFDictionaryRef userInfo)
{
	got_event = 1;
	fprintf(stderr, "got event: %s\n", CFStringGetCStringPtr(name, kCFStringEncodingUTF8));
	CFRunLoopStop(CFRunLoopGetCurrent());
}


void on_cf_timer(CFRunLoopTimerRef timer, void * context)
{
	CFRunLoopStop(CFRunLoopGetCurrent());
}

int main()
{
	CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, TRUE);

	const void * keys[] = {CFSTR("DiskImageMountPath"), 0};
	const void * vals[] = {CFSTR(FAKE_MOUNT_PATH), 0};
	CFDictionaryRef dict = CFDictionaryCreate(kCFAllocatorDefault, keys, vals, 1,
											  &kCFTypeDictionaryKeyCallBacks,
											  &kCFTypeDictionaryValueCallBacks);
	// recv event on succ.
	CFNotificationCenterRef center = CFNotificationCenterGetDarwinNotifyCenter();
	CFNotificationCenterAddObserver(center, NULL, newsvc_callback, CFSTR("com.apple.mobile.new_service_available"),
									NULL, CFNotificationSuspensionBehaviorDeliverImmediately);

	// notify lockdownd...
	CFNotificationCenterRef c_dis = CFNotificationCenterGetDistributedCenter();
	CFNotificationCenterPostNotification(c_dis, CFSTR("com.apple.mobile.disk_image_mounted"), CFSTR("MobileStorageMounter"), dict, true);

	// create a timer, 3 seconds, for timeout recieving event.
	double timerInterval = 3.0;
	CFRunLoopTimerRef t = CFRunLoopTimerCreate(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + timerInterval,
											   0, 0, 0, on_cf_timer, NULL);
	CFRunLoopAddTimer(CFRunLoopGetCurrent(), t, kCFRunLoopDefaultMode);
	CFRunLoopRun();
	return got_event ? 0 : 1;
}
