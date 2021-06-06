from paho.mqtt.client import Client
from paho import mqtt
import time

def main():
    client_name = 'subscriber'
    connection_params = {'host': '192.168.1.40',
                         'port': 1883,
                         'keepalive': 60,
                         'bind_address': ''}

    client = Client(client_name)
    client.on_message = on_message
    client.on_log = on_log
    client.on_connect = on_connect

    # client.loop_start()

    client.connect(**connection_params)

    client.subscribe('main')
    client.loop_start()
    while True:
        time.sleep(0.1)

    client.loop_stop()
    client.disconnect()

def on_log(client, userdata, level, buf):
    print("log: ",buf)

def on_connect(client, userdata, flags, rc):
    if rc==0:
        print("connected OK Returned code=",rc)
    else:
        print("Bad connection Returned code=",rc)

def on_message(client, userdata, message: mqtt.client.MQTTMessage):
    print('Mesage received', str(message.payload.decode("utf-8")))
    print('Message topic', message.topic)
    print('Message qos=', message.qos)
    print('Message retain flag=', message.retain)


if __name__ == '__main__':
    main()