#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include <mpv/client.h>

#include <libgslight/base.h>
#include <libgslight/base.h>

#ifdef __cplusplus
extern "C" {
#endif

bool startsWith(const char *a, const char *b) {
    if(strncmp(a, b, strlen(b)) == 0) return 1;
    return 0;
}

int mpv_open_cplugin(mpv_handle *handle) {
    //GSlight_Init()
    //GSlight_Applist()
    while (1) {
        mpv_event *event = mpv_wait_event(handle, -1);
        char *result = NULL;
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

