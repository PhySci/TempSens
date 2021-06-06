t = require "ds18b20"
pin = 2 -- gpio0 = 3, gpio2 = 4

local function show_sensor_info()
  if t.sens then
    print("Total number of DS18B20 sensors: ".. #t.sens)
    for i, s in ipairs(t.sens) do
      print(string.format("  sensor #%d address: %s%s",  i,
        ('%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X'):format(s:byte(1,8)),
        s:byte(9) == 1 and " (parasite)" or ""))
      end
  end
end


local function readout(temps)
  for addr, temp in pairs(temps) do
    print(string.format("Sensor %s: %s °C", ('%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X'):format(addr:byte(1,8)), temp))
  end
end

  -- Module can be released when it is no longer needed
  --t = nil
  --package.loaded["ds18b20"]=nil


local function fourth_level()
    t.sens={}
    t:read_temp(readout, pin, t.C, false, nil)
end

local function connect_clb(a)
  print('Callback')
  print(a.SSID)
  print(a.BSSID)
  print(a.channel)
  print(wifi.sta.getip())
end  

local function wifi_wait_ip()
  if wifi.sta.getip() == nil then
    print("IP is unavailable. Waiting...")
  else
    print(wifi.sta.getip())
    tObj:stop()
    tObj:unregister()
    --wifi.sta.getap(connect_clb)
  end  
end

do
  wifi.setmode(wifi.STATION)
  wifi.sta.config{ssid="MyNet", pwd="dfqafqdfqafq"}
  wifi.sta.connect()

  tObj = tmr.create()
  tObj:alarm(2000, tmr.ALARM_AUTO, wifi_wait_ip)
  
  -- tmr.create():alarm(1000, tmr.ALARM_AUTO, wifi_wait_ip)
  -- tmr.alarm(0, 5000, tmr.ALARM_SINGLE, )
  -- print(wifi.sta.getip())
  
  -- t:enable_debug()
  -- file.remove("ds18b20_save.lc") -- remove saved addresses
  -- t:read_temp(readout, pin, t.C, true, true)

  -- show_sensor_info()

  -- tmr.create():alarm(2000, tmr.ALARM_AUTO, fourth_level)
end
