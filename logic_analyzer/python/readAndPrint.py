
import serial
import sys

ser = serial.Serial('/dev/ttyUSB1')

sizeVal = 45776#18*44100
count = 0
while True:
    ser.read(size=sizeVal)
    #val = ser.read(size=sizeVal)[0]
    #sys.stdout.write('{0:08b}'.format(ord(val))+"\n") # Prints the 8-bit value in binary format
    sys.stdout.write(str(count)+"\n")
    sys.stdout.write("\033[F") # Cursor up one line
    count += sizeVal


