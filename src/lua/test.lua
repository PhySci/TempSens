ds18 = require("ds18b20")
pin = 3 -- gpio0 = 3, gpio2 = 4
app = require("application")
config = require("config")
set = require("setup")


local function readout(temps)
  for addr, temp in pairs(temps) do
    str = string.format("Sensor %s: %s °C", ('%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X'):format(addr:byte(1,8)), temp)
    -- print(str)
    app.mqtt_send(str)
  end
end


local function read_temp()
  print("Read temp")   
  ds18.sens={}
  ds18:read_temp(readout, pin, ds18.C, false, nil)
end


local function application()
  tmr.create():alarm(1000, tmr.ALARM_AUTO, read_temp)
end



do  
  print("Im here")
  -- application()
  --ds18:enable_debug()
  file.remove("ds18b20_save.lc") -- remove saved addresses
  set.connect_clb = app.start
  app.connect_clb = application
  set.start()

end
