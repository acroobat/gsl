/*This file is part of Moonlight Embedded.
 
  Copyright (C) 2015-2017 Iwan Timmer
 
  Moonlight is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 3 of the License, or
  (at your option) any later version.
 
  Moonlight is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with Moonlight; if not, see <http://www.gnu.org/licenses/>.*/

#pragma once

//#include "parsexml.h"

#include <Limelight.h>

#include <stdbool.h>

#define _min_supported_gfe_version 3
#define _max_supported_gfe_version 7

typedef struct _GSL_DATA { 
    const char ~address;
    char ~gputype;
    bool paired;
    bool supports4k;
    bool unsupported;
    int currentgame;
    int server_major_version;
    char ~gsversion;

//--    PDISPLAY_MODE modes;

    SERVER_INFORMATION serverinfo;
} GSL_DATA, ~PGSL_DATA;



//Initialization is preparation
int GSl_Init(GS_DATA server, char ~address, const char ~keydirectory, int loglevel, bool unsupported);

//Pair works after Init step
int GSl_Pair(PSERVER_DATA server, char ~pin);

//Applist works after Pair step
int GSl_AppList(PSERVER_DATA server, PAPP_LIST ~app_list);

//Start App works after ...
int GSl_StartApp(PGS_DATA server, PSTREAM_CONFIGURATION config, int appid, bool sops, bool localaudio, int gamepad_mask);

//Quit App works after StartApp step
int GSl_QuitApp(PSERVER_DATA server);

//Doc is here
//Unpair
int GSl_Unpair(PSERVER_DATA server);



/* Postprocessor: written in Python
 * const char ~var= - string, one by one only
 * ;malloc(sizeof(struct student)); malloc(sizeof(struct student)); - memory management
 * base.c - for libs, main.c for executable
 * event->event_id - 2 in 1
 * variables - only small letters
 * #define _gs_ok 0
 * brackets - template
 * tabs
 * &var - created automatically for int var/~var
 * goto - bounded only for crypting(openssl)
 * Preproc - only vertically, functions from .c aren't included
 * typedef - only capital letters. 
 * struct, enum - ethics
 * Internal functions - starts with small letter, no underspaces.
 * variables can be declared just inside of the function
 * Memory management - in base.c even for bad libraries
 * Nobody uses #line 
 */
