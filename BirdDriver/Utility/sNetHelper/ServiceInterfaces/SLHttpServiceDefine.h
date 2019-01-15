//
//  SLHttpServiceDefine.h
//  SmartLife
//
//  Created by Potter on 2018/1/2.
//

#ifndef SLHttpServiceDefine_h
#define SLHttpServiceDefine_h

#ifndef __OPTIMIZE__
    #define kServiceDebug 1
#else
    #define kServiceDebug 0
#endif

#if kServiceDebug
    #define BASE_ADDRESS   @"http://dev.myiot360.com/"
#else
    #define BASE_ADDRESS   @"https://web.myiot360.com/"
#endif



#endif /* SLHttpServiceDefine_h */
