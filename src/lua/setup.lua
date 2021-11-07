local module = {}
module.connect_clb = nil

local function wifi_wait_ip()
  if wifi.sta.getip()== nil then
    print("Waiting for IP ...")
  else
    print("Got IP")
    tObj:stop()
    print("\n====================================")
    print("ESP8266 mode is: " .. wifi.getmode())
    print("MAC address is: " .. wifi.ap.getmac())
    print("IP is "..wifi.sta.getip())
    print("====================================")
    module.connect_clb()
  end
end


local function wifi_start(list_aps)
    if list_aps then
        for key, value in pairs(list_aps) do
            if config.SSID and config.SSID[key] then
                wifi.setmode(wifi.STATION);
                local station_cfg = {}
                station_cfg.ssid = key
                station_cfg.pwd = config.SSID[key]
                station_cfg.save = false
                wifi.sta.config(station_cfg)
                wifi.sta.connect()
                print("Connecting to " .. key .. " ...")
                tObj = tmr.create()
                tObj:alarm(1000, tmr.ALARM_AUTO, wifi_wait_ip)
            end
        end
    else
        print("Error getting AP list")
    end
end

function module.start(clb_function)
  module.clb_func = clb_function
  print("Configuring Wifi ...")
  wifi.setmode(wifi.STATION)
  wifi.sta.getap(wifi_start)
end

return module
