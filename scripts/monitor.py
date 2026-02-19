import requests
import sys

# החלף ל-IP של השרת שלך מבלוק 1
URL = "http://13.61.145.119" 

def check_health():
    try:
        response = requests.get(URL, timeout=5)
        if response.status_code == 200:
            print(f"SUCCESS: {URL} is UP!")
        else:
            print(f"WARNING: {URL} returned status {response.status_code}")
    except Exception as e:
        print(f"ERROR: {URL} is DOWN! Details: {e}")

if __name__ == "__main__":
    check_health()