import paho.mqtt.client as mqtt
import random
import time


def main():
    client_name = 'PyCharm'
    client = mqtt.Client(client_id=client_name)

    connection_params = {'host': '192.168.1.40',
                         'port': 1883,
                         'keepalive': 60,
                         'bind_address': ''}
    client.connect(**connection_params)
    client.loop_start()

    for i in range(10):
        (rc, mid) = client.publish('nodemcu/ping', payload='ON_'+str(i), qos=1)
        if rc != 0:
            print('Error')
        else:
            print('Message id ', mid)
        time.sleep(5)
    client.loop_stop()
    client.disconnect()


if __name__ == '__main__':
    main()
