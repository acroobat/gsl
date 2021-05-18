/*
//This file is part of Moonlight Embedded.
 
  Copyright (C) 2015-2017 Iwan Timmer
 
  Moonlight is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 3 of the License, or
  (at your option) any later version.
 
  Moonlight is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with Moonlight; if not, see <http://www.gnu.org/licenses/>.
 */

#pragma once

#include "xml.h"

#include <Limelight.h>

#include <stdbool.h>

#define _min_supported_gfe_version 3
#define _max_supported_gfe_version 7

typedef struct _SERVER_DATA {
    const char* address;
    char* gputype;
    bool paired;
    bool supports4k;
    bool unsupported;
    int currentgame;
    int server_major_version;
    char* gsversion;
    PDISPLAY_MODE modes;
    SERVER_INFORMATION  serverinfo;
} SERVER_DATA, *PSERVER_DATA;

int gs_init(PSERVER_DATA server, char* address, const char *keydirectory, int loglevel, bool unsupported);
int gs_start_app(PSERVER_DATA server, PSTREAM_CONFIGURATION config, int appid, bool sops, bool localaudio, int gamepad_mask);
int gs_applist(PSERVER_DATA server, PAPP_LIST *app_list);
int gs_unpair(PSERVER_DATA server);
int gs_pair(PSERVER_DATA server, char* pin);
int gs_quit_app(PSERVER_DATA server);
