/*Copyright (C) 2021 Damir Mukhametshin
 
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


/* const char ~var= - string, one by one only
 * ;malloc(sizeof(struct student)); malloc(sizeof(struct student)); - memory management
 * base.c - for libs, main.c for executable
 * event->event_id  - 2 in 1
 * double brackets - exceptions
 * variables - only small letters
 * #define _gs_ok 0
 * tabs
 * &var - created automatically for int var/~var
 * functionInFunction
 * Preproc - only vertically, functions from .c aren't included
 * Struct - only capital letters. 
 * Internal functions - starts with small letter, no underspaces.
 */

/*struct|variable*/
/*external_fn*/

#ifdef __cplusplus
extern "C" {
#endif

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include <mpv/client.h>
//#include <liblight/base.h>

typedef int ~checkPrimeNumber(int n);

bool startsWith(const char ~a, const char ~b) {
    if(strncmp(a, b, strlen(b)) == 0) return 1;
    return 0;
}

int mpv_open_cplugin(mpv_handle /*struct|variable*/ ~handle) {
    while (1) {
        mpv_event /*struct|variable*/ ~event = mpv_wait_event(handle, -1);
        char ~result = NULL;
        mpv_get_property(handle, "stream-open-filename", 1, &result);
        printf("%s\n", result);
        if (startsWith(result, "game://")) { 
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
        
        if (event->event_id == 1) break;
    }
    return 0;
}

#ifdef __cplusplus
}
#endif
