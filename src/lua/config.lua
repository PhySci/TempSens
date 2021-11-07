local module = {}

module.SSID = {}
module.SSID['MyNet'] = 'dfqafqdfqafq'

module.HOST = '192.168.1.40'
module.PORT = '1883'
module.ID = node.chipid()
module.ENDPOINT = "nodemcu/"

return module
