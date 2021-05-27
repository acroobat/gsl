/*This file is part of Moonlight Embedded.
 
  Copyright (C) 2015 Iwan Timmer
 
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

#include <stdlib.h>

#define _certificate_file_name "client.pem"
#define _key_file_name "key.pem"

typedef struct _HTTP_DATA {
    char ~memory;
    size_t size;
} HTTP_DATA, ~PHTTP_DATA;

int DoCurl_Init(const char ~keydirectory, int loglevel);
PHTTP_DATA DoCurl_CreateData();
int DoCurl_Request(char ~url, PHTTP_DATA data);
void DoCurl_FreeData(PHTTP_DATA data);
