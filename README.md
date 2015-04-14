# PL7223

The driver class for the PL7223 is based on a datasheet under NDA (non-disclosure agreement). As such, we cannot open source the driver class, however we can make it available through Electric Imp's library management system.

## Class Usage

## constructor(spi, resetPin, chipSelectPin)

To instantiate a new PL7223 object, you must pass it three parameters: a pre-configured SPI bus, a reset pin, and a chip select pin:

```squirrel
#require "PL7223.class.nut:1.0"

// Configure Power Monitoring:
spi <- hardware.spi257;
spi.configure(CLOCK_IDLE_LOW, 100);

power <- PL7223(spi, hardware.pinB, hardware.pin8);
```

## power.sample(*[callback]*)

The sample method takes a reading, and returns the Voltage (Volts), Current (Amps), and Power (watts).

An optional callback may be passed into the method. If the callback is not supplied, a table will be returned with the three values: *voltage*, *current*, and *power* (see example below). If a callback method is provided, the callback will be executed with the same data structure.

```squirrel
// no callback
local powerData = power.sample();
server.log("Voltage: " + powerData.voltage + "V");
server.log("Current: " + powerData.current + "A");
server.log("Power: " + powerData.power + "W");

// with a callback:
power.sample(function(powerData) {
  server.log("Voltage: " + powerData.voltage + "V");
  server.log("Current: " + powerData.current + "A");
  server.log("Power: " + powerData.power + "W");
});
```
## License

The example code in this library is licensed under the [MIT License](./LICENSE).
