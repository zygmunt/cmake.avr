#!/usr/bin/python

import sys
import serial

def main():
    if len(sys.argv) < 2:
        print("Provide device name, for example: /dev/ttyACM0")
        exit(1)

    d = serial.Serial(sys.argv[1], 1200)
    d.close()

if __name__ == "__main__":
    main()
