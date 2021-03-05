import parsecfg, parsexml, strutils, openssl, httpclient
import Limelight

const
  uniquie_id="0123456789ABCDEF"

var client = newHttpClient()
echo client.getContent("http://localhost:47989/serverinfo")

var dict = loadConfig("config")
var adress = dict.getSectionValue("Network","adress")
var packetsize = dict.getSectionValue("Network","packetsize")
var width = dict.getSectionValue("Video","width")
var hight = dict.getSectionValue("Video","hight")
var fps = dict.getSectionValue("Video","fps")
var debug_level = dict.getSectionValue("Misc","debug_level")
var unsupported = dict.getSectionValue("Misc","unsupported")
var key_dir = dict.getSectionValue("Misc","key_dir")

#var initserver: SERVER_DATA
var initserver = SERVER_DATA(address : adress,
              serverInfoAppVersion : "test",
              serverInfoGfeVersion : "test")

#initserver.gs_init()

