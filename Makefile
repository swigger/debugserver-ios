CC=gcc
include Makefile.in
CFLAGS+=
LDFLAGS+=
OBJS=PseudoTerminal.o LogFilterExactMatch.o MachTask.o OsLogger.o PThreadMutex.o DNBThreadResumeActions.o RNBSocket.o DNB.o Genealogy.o DNBRegisterInfo.o debugserver.o MachProcess.o MachException.o SocketAddress.o DNBArchImpl.o LogMessage.o DNBLog.o JSON.o StdStringExtractor.o PThreadEvent.o DarwinLogCollector.o DNBArchImplI386.o DNBBreakpoint.o DNBError.o CFString.o debugserver_vers.o DNBArchImplX86_64.o LogMessageOsLog.o DNBArch.o StringConvert.o RNBRemote.o CFBundle.o MachThreadList.o LogFilter.o RNBContext.o LogFilterRegex.o LogFilterChain.o SysSignal.o DNBArchImpl1.o DNBArchImplARM64.o MachVMRegion.o RNBServices.o MachVMMemory.o ActivityStore.o dbgnub-migServer.o MachThread.o DNBDataRef.o dbgnub-migUser.o

all : dbgsrv64


PseudoTerminal.o : ../../../tools/debugserver/source/PseudoTerminal.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

LogFilterExactMatch.o : ../../../tools/debugserver/source/MacOSX/DarwinLog/LogFilterExactMatch.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

MachTask.o : ../../../tools/debugserver/source/MacOSX/MachTask.mm
	$(CC) -c $(CFLAGS) -o $@ $<

OsLogger.o : ../../../tools/debugserver/source/MacOSX/OsLogger.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

PThreadMutex.o : ../../../tools/debugserver/source/PThreadMutex.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNBThreadResumeActions.o : ../../../tools/debugserver/source/DNBThreadResumeActions.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

RNBSocket.o : ../../../tools/debugserver/source/RNBSocket.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNB.o : ../../../tools/debugserver/source/DNB.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

Genealogy.o : ../../../tools/debugserver/source/MacOSX/Genealogy.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNBRegisterInfo.o : ../../../tools/debugserver/source/DNBRegisterInfo.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

debugserver.o : ../../../tools/debugserver/source/debugserver.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

MachProcess.o : ../../../tools/debugserver/source/MacOSX/MachProcess.mm
	$(CC) -c $(CFLAGS) -o $@ $<

MachException.o : ../../../tools/debugserver/source/MacOSX/MachException.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

SocketAddress.o : ../../../source/Host/common/SocketAddress.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNBArchImpl.o : ../../../tools/debugserver/source/MacOSX/arm/DNBArchImpl.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

LogMessage.o : ../../../tools/debugserver/source/MacOSX/DarwinLog/LogMessage.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNBLog.o : ../../../tools/debugserver/source/DNBLog.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

JSON.o : ../../../tools/debugserver/source/JSON.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

StdStringExtractor.o : ../../../tools/debugserver/source/StdStringExtractor.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

PThreadEvent.o : ../../../tools/debugserver/source/PThreadEvent.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DarwinLogCollector.o : ../../../tools/debugserver/source/MacOSX/DarwinLog/DarwinLogCollector.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNBArchImplI386.o : ../../../tools/debugserver/source/MacOSX/i386/DNBArchImplI386.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNBBreakpoint.o : ../../../tools/debugserver/source/DNBBreakpoint.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNBError.o : ../../../tools/debugserver/source/DNBError.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

CFString.o : ../../../tools/debugserver/source/MacOSX/CFString.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

debugserver_vers.o : ./debugserver_vers.c
	$(CC) -c $(CFLAGS) -o $@ $<

DNBArchImplX86_64.o : ../../../tools/debugserver/source/MacOSX/x86_64/DNBArchImplX86_64.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

LogMessageOsLog.o : ../../../tools/debugserver/source/MacOSX/DarwinLog/LogMessageOsLog.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNBArch.o : ../../../tools/debugserver/source/DNBArch.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

StringConvert.o : ../../../source/Host/common/StringConvert.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

RNBRemote.o : ../../../tools/debugserver/source/RNBRemote.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

CFBundle.o : ../../../tools/debugserver/source/MacOSX/CFBundle.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

MachThreadList.o : ../../../tools/debugserver/source/MacOSX/MachThreadList.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

LogFilter.o : ../../../tools/debugserver/source/MacOSX/DarwinLog/LogFilter.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

RNBContext.o : ../../../tools/debugserver/source/RNBContext.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

LogFilterRegex.o : ../../../tools/debugserver/source/MacOSX/DarwinLog/LogFilterRegex.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

LogFilterChain.o : ../../../tools/debugserver/source/MacOSX/DarwinLog/LogFilterChain.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

SysSignal.o : ../../../tools/debugserver/source/SysSignal.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNBArchImpl1.o : ../../../tools/debugserver/source/MacOSX/ppc/DNBArchImpl.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNBArchImplARM64.o : ../../../tools/debugserver/source/MacOSX/arm64/DNBArchImplARM64.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

MachVMRegion.o : ../../../tools/debugserver/source/MacOSX/MachVMRegion.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

RNBServices.o : ../../../tools/debugserver/source/RNBServices.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

MachVMMemory.o : ../../../tools/debugserver/source/MacOSX/MachVMMemory.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

ActivityStore.o : ../../../tools/debugserver/source/MacOSX/DarwinLog/ActivityStore.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

dbgnub-migServer.o : ./dbgnub-migServer.c
	$(CC) -c $(CFLAGS) -o $@ $<

MachThread.o : ../../../tools/debugserver/source/MacOSX/MachThread.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

DNBDataRef.o : ../../../tools/debugserver/source/DNBDataRef.cpp
	$(CC) -c $(CXXFLAGS) -o $@ $<

dbgnub-migUser.o : ./dbgnub-migUser.c
	$(CC) -c $(CFLAGS) -o $@ $<

dbgsrv64 : $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)
	cp $@ $@.dbg
	strip $@
	ldid -Sent2.xml $@.dbg
	ldid -Sent2.xml $@

clean:
	-@ rm -f $(OBJS)
