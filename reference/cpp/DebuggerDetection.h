#pragma once

#include <windows.h>
#include <winternl.h>
#include <iostream>

// Debugger detection techniques for anti-tampering measures
namespace DebuggerDetection {

    // Method 1: Basic debugger detection using Windows API
    inline bool IsBeingDebugged() {
        return IsDebuggerPresent() != 0;
    }

    // Method 2: Detect remote debuggers
    inline bool IsRemoteDebuggerAttached() {
        BOOL present = FALSE;
        CheckRemoteDebuggerPresent(GetCurrentProcess(), &present);
        return present != 0;
    }

    // Method 3: Check PEB (Process Environment Block) BeingDebugged flag
    inline bool IsBeingDebuggedViaPEB() {
#if defined(_M_X64)
        PPEB peb = (PPEB)__readgsqword(0x60);
#elif defined(_M_IX86)
        PPEB peb = (PPEB)__readfsdword(0x30);
#else
        return false; // not implemented for this architecture
#endif
        return peb->BeingDebugged != 0;
    }

    // Method 4: Check for debug port via NtQueryInformationProcess
    inline bool IsDebugPortPresent() {
        HMODULE ntdll = GetModuleHandleW(L"ntdll.dll");
        if (!ntdll) return false;

        typedef NTSTATUS (WINAPI *pNtQueryInformationProcess)(
            HANDLE, PROCESSINFOCLASS, PVOID, ULONG, PULONG);

        auto NtQIP = (pNtQueryInformationProcess)GetProcAddress(ntdll, "NtQueryInformationProcess");
        if (!NtQIP) return false;

        DWORD_PTR debugPort = 0;
        ULONG returnLength = 0;
        NTSTATUS status = NtQIP(GetCurrentProcess(), ProcessDebugPort,
                                &debugPort, sizeof(debugPort), &returnLength);

        return NT_SUCCESS(status) && debugPort != 0;
    }

    // Method 5: Heuristic detection via OutputDebugString
    inline bool IsDebuggerPresentViaOutputDebugString() {
        SetLastError(0);
        OutputDebugStringW(L"");
        return GetLastError() == 0;
    }

    // Combined check using multiple methods for robust detection
    inline bool IsDebuggerAttached() {
        return IsBeingDebugged() ||
               IsRemoteDebuggerAttached() ||
               IsBeingDebuggedViaPEB() ||
               IsDebugPortPresent();
    }

    // Handle debugger state with appropriate responses
    inline void HandleDebuggerState(bool debugged) {
        if (debugged) {
            std::cout << "[Info] Debugger detected — disabling verbose internal diagnostics"
                      " and running in production-safe mode.\n";
            // Additional anti-tampering actions:
            // - Skip sensitive logging
            // - Disable debug output
            // - Run in reduced capability mode
            // - etc.
        } else {
            std::cout << "[Info] No debugger detected — normal execution.\n";
        }
    }
}
