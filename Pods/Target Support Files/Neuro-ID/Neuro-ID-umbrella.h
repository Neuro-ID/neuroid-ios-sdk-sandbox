#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NeuroID.h"

FOUNDATION_EXPORT double Neuro_IDVersionNumber;
FOUNDATION_EXPORT const unsigned char Neuro_IDVersionString[];

