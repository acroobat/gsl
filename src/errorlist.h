/*This file is part of Moonlight Embedded.
 
  Copyright (C) 2015, 2016 Iwan Timmer
 
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

#define _gs_ok 0
#define _gs_failed -1
#define _gs_out_of_memory -2
#define _gs_invalid -3
#define _gs_wrong_state -4
#define _gs_io_error -5
#define _gs_not_supported_4k -6
#define _gs_unsupported_version -7
#define _gs_not_supported_mode -8
#define _gs_error -9
#define _gs_not_supported_sops_resolution -10

extern const char* gs_error;
