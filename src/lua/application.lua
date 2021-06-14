local module = {}
m = nil
module.conn_status = false

-- Send a simple ping to the broker

local function mqtt_clb_puback(client)
  print("Published a message")
end

local function mqtt_clb_suback(client)
  print('Subscribed successfully')
end

local function mqtt_clb_connect(a)
  print('Connect callback')
  module.conn_status = true
  client:subscribe(config.ENDPOINT .. "ping", 0)
end

local function mqtt_clb_connfail(client, code)
  print('Connection is failed' .. code)
end

local function mqtt_clb_message(conn, topic, data)
  if data ~= nil then
    print(topic .. ": " .. data)
  -- do something, we have received a message
  end
end

local function send_msg()
  print(module.conn_status)
  client:publish(config.ENDPOINT .. "ping", 'test', 0, 0)
end

local function mqtt_start()
  -- What does this call do? 
  print('MQTT start')
  client = mqtt.Client(config.ID, 120)
  
  client:on("message", mqtt_clb_message)
  client:on("connect", mqtt_clb_connect)
  client:on("connfail", mqtt_clb_connfail)
  client:on("puback", mqtt_clb_puback)
  client:on("suback", mqtt_clb_suback)
   
  client:connect(config.HOST, config.PORT, 0)
end

function module.start()
  mqtt_start()

  print(module.conn_status)

  
  print('Ifs')
  t = tmr.create() 
  tObj:alarm(2000, tmr.ALARM_AUTO, send_msg)

end

return module
  
  
 
  
