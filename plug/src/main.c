
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
        printf("Hello world from C plugin '%s'!\n", mpv_client_name(handle));

    
        while (1) {
            mpv_event *event = mpv_wait_event(handle, -1);
            char *result = NULL;
            mpv_get_property(handle, "stream-open-filename", MPV_FORMAT_STRING, &result);
            //printf("Got event: %d\n", event->event_id);
            if(StartsWith(result, "game://")) { 
                mpv_set_option_string(handle, "input-vo-keyboard", "no");
               mpv_set_option_string(handle, "terminal", "no");
                result += 7;
              char testcmd[100];
                sprintf(testcmd, "moonlight stream -app %s", result);
                system(testcmd);
            //    char *stream = "";
            //mpv_set_property(handle, "stream-open-filename", MPV_FORMAT_STRING, &stream);
            }
            
            if (event->event_id == MPV_EVENT_PAUSE)
            {
                const char *cmd[] = {"show-text", "pause", 0};
              //  mpv_command(handle,testcmd);
           //     printf("%s\n", result);
            }
            if (event->event_id == MPV_EVENT_SHUTDOWN)
                break;
        }
        return 0;
    }

