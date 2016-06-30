import serial
class Arduino():
    def __init__(self,serial_port='/dev/ttyACM0',baud_rate=9600,read_timeout=5):
        self.conn = serial.Serial(serial_port,baud_rate)
        self.conn.timeout = read_timeout
    def set_pin_mode(self,pin_number,mode):
        command = (''.join(('M',mode,str(pin_number)))).encode()
        print('set_pin_mode =',command,(''.join(('M',mode,str(pin_number)))))
        self.conn.write(command)
    def digital_read(self,pin_number):
        command = (''.join(('RD',str(pin_number)))).encode()
        self.conn.write(command)
        line_received = self.conn.readline().decode().strip()
        header, value = line_received.split(':')
        if header == ('D'+str(pin_number)):
            return int(value)
    def digital_write(self,pin_number,digital_value):
        command = (''.join(('WD',str(pin_number),':',str(digital_value)))).encode()
        self.conn.write(command)
    def analog_read(self,pin_number):
        command = (''.join(('RA',str(pin_number)))).encode()
        self.conn.write(command)
        line_received = self.conn.readline().decode().strip()
        header, value = line_received.split(':')
        if header == ('A'+str(pin_number)):
            return int(value)
    def analog_write(self,pin_number,analog_value):
        command = (''.join(('WA',str(pin_number),':',str(analog_value)))).encode()
        self.conn.write(command)
    def close(self):
        self.conn.close()
        print('Connection to arduino closed')
