#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include <mpv/client.h>

#include <gsl/base.h>
#include <Limelight.h>

#ifdef __cplusplus
extern "C" {
#endif

bool startsWith(const char *a, const char *b) {
    if(strncmp(a, b, strlen(b)) == 0) return 1;
    return 0;
}

static int mpv_renderer_setup(int videoFormat, int width, int height, int redrawRate, void *context, int drFlags) {};

void mpv_cleanup() {
}

int mpv_submit_decode_unit(PDECODE_UNIT decodeUnit) {}

int mpv_open_cplugin(mpv_handle *handle) {
    PGSL_DATA server;
    //GSl_Init()
    //GSl_Pair()
    //GSl_Applist()
    //GSl_StartApp()
    
    //LiStartConnection(&server->serverinfo, &config->stream, &connection_callbacks, (DECODER_RENDERER_CALLBACKS)decoder_callbacks_mpv, platform_get_audio(system, config->audio_device), NULL, drFlags, config->audio_device, 0);
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


DECODER_RENDERER_CALLBACKS decoder_callbacks_mpv = {
  .setup = mpv_renderer_setup,
  .cleanup = mpv_renderer_cleanup,
  .submitDecodeUnit = mpv_submit_decode_unit,
  .capabilities = CAPABILITY_DIRECT_SUBMIT,
};
    
AUDIO_RENDERER_CALLBACKS audio_callbacks_alsa = {
  .init = alsa_renderer_init,
  .cleanup = alsa_renderer_cleanup,
  .decodeAndPlaySample = alsa_renderer_decode_and_play_sample,
  .capabilities = CAPABILITY_DIRECT_SUBMIT,
};

#ifdef __cplusplus
}
#endif
