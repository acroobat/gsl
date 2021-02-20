const
  libname = "libmoonlight-common.so.4"
const
  STREAM_CFG_LOCAL* = 0
  STREAM_CFG_REMOTE* = 1
  STREAM_CFG_AUTO* = 2


const
  COLORSPACE_REC_601* = 0
  COLORSPACE_REC_709* = 1
  COLORSPACE_REC_2020* = 2


const
  COLOR_RANGE_LIMITED* = 0
  COLOR_RANGE_FULL* = 1

type
  STREAM_CONFIGURATION* {.bycopy.} = object
    width*: cint
    height*: cint
    fps*: cint
    bitrate*: cint
    packetSize*: cint
    streamingRemotely*: cint
    audioConfiguration*: cint
    supportsHevc*: cint
    enableHdr*: cint
    hevcBitratePercentageMultiplier*: cint
    clientRefreshRateX100*: cint
    colorSpace*: cint
    colorRange*: cint
    remoteInputAesKey*: array[16, char]
    remoteInputAesIv*: array[16, char]

  PSTREAM_CONFIGURATION* = ptr STREAM_CONFIGURATION


proc LiInitializeStreamConfiguration*(streamConfig: PSTREAM_CONFIGURATION){.cdecl, dynlib: libname,importc: "LiInitializeStreamConfiguration".}

const
  BUFFER_TYPE_PICDATA* = 0x00000000
  BUFFER_TYPE_SPS* = 0x00000001
  BUFFER_TYPE_PPS* = 0x00000002
  BUFFER_TYPE_VPS* = 0x00000003

type
  LENTRY* {.bycopy.} = object
    next*: ptr LENTRY
    data*: cstring
    length*: cint
    bufferType*: cint

  PLENTRY* = ptr LENTRY


const
  FRAME_TYPE_PFRAME* = 0x00000000


const
  FRAME_TYPE_IDR* = 0x00000001


type
  DECODE_UNIT* {.bycopy.} = object
    frameNumber*: cint
    frameType*: cint
    receiveTimeMs*: uint64
    enqueueTimeMs*: uint64
    presentationTimeMs*: cuint
    fullLength*: cint
    bufferList*: PLENTRY

  PDECODE_UNIT* = ptr DECODE_UNIT

template MAKE_AUDIO_CONFIGURATION*(channelCount, channelMask: untyped): untyped =
  (((channelMask) shl 16) or (channelCount shl 8) or 0x000000CA)

const
  AUDIO_CONFIGURATION_STEREO* = MAKE_AUDIO_CONFIGURATION(2, 0x00000003)


const
  AUDIO_CONFIGURATION_51_SURROUND* = MAKE_AUDIO_CONFIGURATION(6, 0x0000003F)


const
  AUDIO_CONFIGURATION_71_SURROUND* = MAKE_AUDIO_CONFIGURATION(8, 0x0000063F)




template CHANNEL_COUNT_FROM_AUDIO_CONFIGURATION*(x: untyped): untyped =
  (((x) shr 8) and 0x000000FF)

template CHANNEL_MASK_FROM_AUDIO_CONFIGURATION*(x: untyped): untyped =
  (((x) shr 16) and 0x0000FFFF)


template SURROUNDAUDIOINFO_FROM_AUDIO_CONFIGURATION*(x: untyped): untyped =
  (CHANNEL_MASK_FROM_AUDIO_CONFIGURATION(x) shl 16 or
      CHANNEL_COUNT_FROM_AUDIO_CONFIGURATION(x))


const
  AUDIO_CONFIGURATION_MAX_CHANNEL_COUNT* = 8


const
  VIDEO_FORMAT_H264* = 0x00000001


const
  VIDEO_FORMAT_H265* = 0x00000100


const
  VIDEO_FORMAT_H265_MAIN10* = 0x00000200


const
  VIDEO_FORMAT_MASK_H264* = 0x000000FF
  VIDEO_FORMAT_MASK_H265* = 0x0000FF00


const
  CAPABILITY_DIRECT_SUBMIT* = 0x00000001


const
  CAPABILITY_REFERENCE_FRAME_INVALIDATION_AVC* = 0x00000002


const
  CAPABILITY_REFERENCE_FRAME_INVALIDATION_HEVC* = 0x00000004


const
  CAPABILITY_SLOW_OPUS_DECODER* = 0x00000008


const
  CAPABILITY_SUPPORTS_ARBITRARY_AUDIO_DURATION* = 0x00000010


template CAPABILITY_SLICES_PER_FRAME*(x: untyped): untyped =
  ((cast[cuchar]((x))) shl 24)


type
  DecoderRendererSetup* = proc (videoFormat: cint; width: cint; height: cint;
                             redrawRate: cint; context: pointer; drFlags: cint): cint{.cdecl.}


type
  DecoderRendererStart* = proc (){.cdecl.}


type
  DecoderRendererStop* = proc (){.cdecl.}


type
  DecoderRendererCleanup* = proc (){.cdecl.}


const
  DR_OK* = 0
  DR_NEED_IDR* = -1

type
  DecoderRendererSubmitDecodeUnit* = proc (decodeUnit: PDECODE_UNIT): cint
  DECODER_RENDERER_CALLBACKS* {.bycopy.} = object
    setup*: DecoderRendererSetup
    start*: DecoderRendererStart
    stop*: DecoderRendererStop
    cleanup*: DecoderRendererCleanup
    submitDecodeUnit*: DecoderRendererSubmitDecodeUnit
    capabilities*: cint

  PDECODER_RENDERER_CALLBACKS* = ptr DECODER_RENDERER_CALLBACKS


proc LiInitializeVideoCallbacks*(drCallbacks: PDECODER_RENDERER_CALLBACKS){.cdecl, dynlib: libname,importc: "LiInitializeVideoCallbacks".}

type
  OPUS_MULTISTREAM_CONFIGURATION* {.bycopy.} = object
    sampleRate*: cint
    channelCount*: cint
    streams*: cint
    coupledStreams*: cint
    samplesPerFrame*: cint
    mapping*: array[AUDIO_CONFIGURATION_MAX_CHANNEL_COUNT, cuchar]

  POPUS_MULTISTREAM_CONFIGURATION* = ptr OPUS_MULTISTREAM_CONFIGURATION


type
  AudioRendererInit* = proc (audioConfiguration: cint;
                          opusConfig: POPUS_MULTISTREAM_CONFIGURATION;
                          context: pointer; arFlags: cint): cint{.cdecl.}


type
  AudioRendererStart* = proc (){.cdecl.}


type
  AudioRendererStop* = proc (){.cdecl.}


type
  AudioRendererCleanup* = proc (){.cdecl.}


type
  AudioRendererDecodeAndPlaySample* = proc (sampleData: cstring; sampleLength: cint)
  AUDIO_RENDERER_CALLBACKS* {.bycopy.} = object
    init*: AudioRendererInit
    start*: AudioRendererStart
    stop*: AudioRendererStop
    cleanup*: AudioRendererCleanup
    decodeAndPlaySample*: AudioRendererDecodeAndPlaySample
    capabilities*: cint

  PAUDIO_RENDERER_CALLBACKS* = ptr AUDIO_RENDERER_CALLBACKS


proc LiInitializeAudioCallbacks*(arCallbacks: PAUDIO_RENDERER_CALLBACKS){.cdecl, dynlib: libname,importc: "LiInitializeAudioCallbacks".}

const
  STAGE_NONE* = 0
  STAGE_PLATFORM_INIT* = 1
  STAGE_NAME_RESOLUTION* = 2
  STAGE_RTSP_HANDSHAKE* = 3
  STAGE_CONTROL_STREAM_INIT* = 4
  STAGE_VIDEO_STREAM_INIT* = 5
  STAGE_AUDIO_STREAM_INIT* = 6
  STAGE_INPUT_STREAM_INIT* = 7
  STAGE_CONTROL_STREAM_START* = 8
  STAGE_VIDEO_STREAM_START* = 9
  STAGE_AUDIO_STREAM_START* = 10
  STAGE_INPUT_STREAM_START* = 11
  STAGE_MAX* = 12


type
  ConnListenerStageStarting* = proc (stage: cint){.cdecl.}


type
  ConnListenerStageComplete* = proc (stage: cint){.cdecl.}


type
  ConnListenerStageFailed* = proc (stage: cint; errorCode: cint){.cdecl.}


type
  ConnListenerConnectionStarted* = proc (){.cdecl.}


type
  ConnListenerConnectionTerminated* = proc (errorCode: cint){.cdecl.}


const
  ML_ERROR_GRACEFUL_TERMINATION* = 0


const
  ML_ERROR_NO_VIDEO_TRAFFIC* = -100


const
  ML_ERROR_NO_VIDEO_FRAME* = -101


const
  ML_ERROR_UNEXPECTED_EARLY_TERMINATION* = -102


type
  ConnListenerLogMessage* = proc (format: cstring) {.varargs.}


type
  ConnListenerRumble* = proc (controllerNumber: cushort; lowFreqMotor: cushort;
                           highFreqMotor: cushort){.cdecl.}


const
  CONN_STATUS_OKAY* = 0
  CONN_STATUS_POOR* = 1

type
  ConnListenerConnectionStatusUpdate* = proc (connectionStatus: cint){.cdecl.}
  CONNECTION_LISTENER_CALLBACKS* {.bycopy.} = object
    stageStarting*: ConnListenerStageStarting
    stageComplete*: ConnListenerStageComplete
    stageFailed*: ConnListenerStageFailed
    connectionStarted*: ConnListenerConnectionStarted
    connectionTerminated*: ConnListenerConnectionTerminated
    logMessage*: ConnListenerLogMessage
    rumble*: ConnListenerRumble
    connectionStatusUpdate*: ConnListenerConnectionStatusUpdate

  PCONNECTION_LISTENER_CALLBACKS* = ptr CONNECTION_LISTENER_CALLBACKS


proc LiInitializeConnectionCallbacks*(clCallbacks: PCONNECTION_LISTENER_CALLBACKS){.cdecl, dynlib: libname,importc: "LiInitializeConnectionCallbacks".}
type
  SERVER_INFORMATION* {.bycopy.} = object
    address*: cstring
    serverInfoAppVersion*: cstring
    serverInfoGfeVersion*: cstring

  PSERVER_INFORMATION* = ptr SERVER_INFORMATION


proc LiInitializeServerInformation*(serverInfo: SERVER_INFORMATION){.cdecl, dynlib: libname,importc: "LiInitializeServerInformation".}

proc LiStartConnection*(serverInfo: PSERVER_INFORMATION;
                       streamConfig: PSTREAM_CONFIGURATION;
                       clCallbacks: PCONNECTION_LISTENER_CALLBACKS;
                       drCallbacks: PDECODER_RENDERER_CALLBACKS;
                       arCallbacks: PAUDIO_RENDERER_CALLBACKS;
                       renderContext: pointer; drFlags: cint; audioContext: pointer;
                       arFlags: cint): cint{.cdecl, dynlib: libname,importc: "LiStartConnection".}

proc LiStopConnection*(){.cdecl, dynlib: libname,importc: "LiStopConnection".}

proc LiInterruptConnection*(){.cdecl, dynlib: libname,importc: "LiInterruptConnection".}

proc LiGetStageName*(stage: cint): cstring{.cdecl, dynlib: libname,importc: "LiGetStageName".}

proc LiSendMouseMoveEvent*(deltaX: cshort; deltaY: cshort): cint{.cdecl, dynlib: libname,importc: "LiSendMouseMoveEvent".}

proc LiSendMousePositionEvent*(x: cshort; y: cshort; referenceWidth: cshort;
                              referenceHeight: cshort): cint{.cdecl, dynlib: libname,importc: "LiSendMousePositionEvent".}

const
  BUTTON_ACTION_PRESS* = 0x00000007
  BUTTON_ACTION_RELEASE* = 0x00000008
  BUTTON_LEFT* = 0x00000001
  BUTTON_MIDDLE* = 0x00000002
  BUTTON_RIGHT* = 0x00000003
  BUTTON_X1* = 0x00000004
  BUTTON_X2* = 0x00000005

proc LiSendMouseButtonEvent*(action: char; button: cint): cint{.cdecl, dynlib: libname,importc: "LiSendMouseButtonEvent".}

const
  KEY_ACTION_DOWN* = 0x00000003
  KEY_ACTION_UP* = 0x00000004
  MODIFIER_SHIFT* = 0x00000001
  MODIFIER_CTRL* = 0x00000002
  MODIFIER_ALT* = 0x00000004
  MODIFIER_META* = 0x00000008

proc LiSendKeyboardEvent*(keyCode: cshort; keyAction: char; modifiers: char): cint{.cdecl, dynlib: libname,importc: "LiSendKeyboardEvent".}

const
  A_FLAG* = 0x00001000
  B_FLAG* = 0x00002000
  X_FLAG* = 0x00004000
  Y_FLAG* = 0x00008000
  UP_FLAG* = 0x00000001
  DOWN_FLAG* = 0x00000002
  LEFT_FLAG* = 0x00000004
  RIGHT_FLAG* = 0x00000008
  LB_FLAG* = 0x00000100
  RB_FLAG* = 0x00000200
  PLAY_FLAG* = 0x00000010
  BACK_FLAG* = 0x00000020
  LS_CLK_FLAG* = 0x00000040
  RS_CLK_FLAG* = 0x00000080
  SPECIAL_FLAG* = 0x00000400


proc LiSendControllerEvent*(buttonFlags: cshort; leftTrigger: cuchar;
                           rightTrigger: cuchar; leftStickX: cshort;
                           leftStickY: cshort; rightStickX: cshort;
                           rightStickY: cshort): cint{.cdecl, dynlib: libname,importc: "LiSendControllerEvent".}

proc LiSendMultiControllerEvent*(controllerNumber: cshort;
                                activeGamepadMask: cshort; buttonFlags: cshort;
                                leftTrigger: cuchar; rightTrigger: cuchar;
                                leftStickX: cshort; leftStickY: cshort;
                                rightStickX: cshort; rightStickY: cshort): cint{.cdecl, dynlib: libname,importc: "LiSendMultiControllerEvent".}

proc LiSendScrollEvent*(scrollClicks: cchar): cint{.cdecl, dynlib: libname,importc: "LiSendScrollEvent".}

proc LiSendHighResScrollEvent*(scrollAmount: cshort): cint{.cdecl, dynlib: libname,importc: "LiSendHighResScrollEvent".}

proc LiGetMillis*(): uint64{.cdecl, dynlib: libname,importc: "LiGetMillis".}

proc LiFindExternalAddressIP4*(stunServer: cstring; stunPort: cushort;
                              wanAddr: ptr cuint): cint{.cdecl, dynlib: libname,importc: "LiFindExternalAddressIP4".}

proc LiGetPendingVideoFrames*(): cint{.cdecl, dynlib: libname,importc: "LiGetPendingVideoFrames".}

proc LiGetPendingAudioFrames*(): cint{.cdecl, dynlib: libname,importc: "LiGetPendingAudioFrames".}

proc LiGetPendingAudioDuration*(): cint{.cdecl, dynlib: libname,importc: "LiGetPendingAudioDuration".}

const
  ML_PORT_INDEX_TCP_47984* = 0
  ML_PORT_INDEX_TCP_47989* = 1
  ML_PORT_INDEX_TCP_48010* = 2
  ML_PORT_INDEX_UDP_47998* = 8
  ML_PORT_INDEX_UDP_47999* = 9
  ML_PORT_INDEX_UDP_48000* = 10
  ML_PORT_INDEX_UDP_48010* = 11


const
  ML_PORT_FLAG_ALL* = 0xFFFFFFFF
  ML_PORT_FLAG_TCP_47984* = 0x00000001
  ML_PORT_FLAG_TCP_47989* = 0x00000002
  ML_PORT_FLAG_TCP_48010* = 0x00000004
  ML_PORT_FLAG_UDP_47998* = 0x00000100
  ML_PORT_FLAG_UDP_47999* = 0x00000200
  ML_PORT_FLAG_UDP_48000* = 0x00000400
  ML_PORT_FLAG_UDP_48010* = 0x00000800


proc LiGetPortFlagsFromStage*(stage: cint): cuint{.cdecl, dynlib: libname,importc: "LiGetPortFlagsFromStage".}
proc LiGetPortFlagsFromTerminationErrorCode*(errorCode: cint): cuint{.cdecl, dynlib: libname,importc: "LiGetPortFlagsFromTerminationErrorCode".}

proc LiGetProtocolFromPortFlagIndex*(portFlagIndex: cint): cint{.cdecl, dynlib: libname,importc: "LiGetProtocolFromPortFlagIndex".}

proc LiGetPortFromPortFlagIndex*(portFlagIndex: cint): cushort{.cdecl, dynlib: libname,importc: "LiGetPortFromPortFlagIndex".}

proc LiStringifyPortFlags*(portFlags: cuint; separator: cstring;
                          outputBuffer: cstring; outputBufferLength: cint){.cdecl, dynlib: libname,importc: "LiStringifyPortFlags".}

const
  ML_TEST_RESULT_INCONCLUSIVE* = 0xFFFFFFFF

proc LiTestClientConnectivity*(testServer: cstring; referencePort: cushort;
                              testPortFlags: cuint): cuint{.cdecl, dynlib: libname,importc: "LiTestClientConnectivity".}
