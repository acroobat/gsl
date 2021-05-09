/*
  Copyright (C) 2021 Damir Mukhametshin
 
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


/*
 * const char *var=
 * typeof enum struct (space) var
 * emp = (struct student*)
 *     malloc(sizeof(struct student));
 * printf("%d", emp->age);
 * event->event_id  - 2 instead of 1
 */

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include <mpv/client.h>

bool StartsWith(const char *a, const char *b)
{
   if(strncmp(a, b, strlen(b)) == 0) return 1;
   return 0;
}

int system(const char *command);


int mpv_open_cplugin(mpv_handle *handle)
    {
        while (1) {
            mpv_event *event = mpv_wait_event(handle, -1);

            char* result = NULL;
            mpv_get_property(handle, "stream-open-filename", MPV_FORMAT_STRING, &result);
            printf("%s\n", result);
            if (StartsWith(result, "game://")) { 
            //    mpv_set_option_string(handle, "input-vo-keyboard", "no");
            //    mpv_set_option_string(handle, "terminal", "no");
                result += 7;
                char testcmd[100];
                sprintf(testcmd, "moonlight stream -app %s", result);
                system(testcmd);
            }
            //uncomment at the end
            //else
            //    break;
            
            if (event->event_id == MPV_EVENT_SHUTDOWN)
                break;
        }
        return 0;
    }
