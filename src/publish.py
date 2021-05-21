import paho.mqtt.client as mqtt
import random
import time

def main():
    client_name = 'publisher'
    client = mqtt.Client(client_name)

    connection_params = {'host': 'localhost',
                         'port': 1883,
                         'keepalive': 60,
                         'bind_address': ''}
    client.connect(**connection_params)
    client.loop_start()

    for i in range(10):
        v = client.publish('main', payload='ON_'+str(i), qos=1)
        print(v)
        time.sleep(1)
    client.loop_stop()
    client.disconnect()


if __name__ == '__main__':
    main()