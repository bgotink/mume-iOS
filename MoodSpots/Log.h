//
//  Log.h
//  MoodSpots
//
//  Created by Bram Gotink on 26/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#ifndef MoodSpots_Log_h
#define MoodSpots_Log_h

#define MSDEBUG 1

#if MSDEBUG
#define MSLog(fmt,...) NSLog(fmt,##__VA_ARGS__);
#else
#define MSLog(...)
#endif

#endif
