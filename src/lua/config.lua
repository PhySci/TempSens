local module = {}

module.SSID = {}
module.SSID['TestNet'] = 'password'

module.HOST = "IP"
module.PORT = 1883
module.ID = node.chipid()

module.ENDPOINT = "nodemcu/"
return module