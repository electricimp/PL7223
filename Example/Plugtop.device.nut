#require "PL7223.class.nut:1.0"
#require "LatchingRelay.class.nut:1.0"
#require "button.class.nut:1.0"
#require "Bullwinkle.class.nut:1.0"

relay <- LatchingRelay(hardware.pin9, hardware.pinA, 0);
button <- Button(hardware.pin1, DIGITAL_IN, 1, relay.toggle.bindenv(relay), null);

// Create Bullwinkle object
bull <- Bullwinkle();

// Configure Power Monitoring:
spi <- hardware.spi257;
spi.configure(CLOCK_IDLE_LOW, 100);

pl <- PL7223(spi, hardware.pinB, hardware.pin8);

// create the nv table if required:
if (!("nv" in getroottable() && "wattSeconds" in nv)) {
  nv <- { wattSeconds = 0 };
}

// Sample function
function sample() {
  // sample every second to get rough estimate of KWH
  imp.wakeup(1.0, sample);
  local sample = pl.sample();

  if (sample != false) nv.wattSeconds += sample.power;
} sample();

// agent handlers
bull.on("getPower", function(context) {
  context.reply(nv.wattSeconds);
});

bull.on("resetPower", function(context) {
  nv.wattSeconds = 0;
  context.reply(nv.wattSeconds);
});

bull.on("getState", function(context) {
  context.reply(relay.getState());
});

bull.on("setState", function(context) {
    relay.write(context.params);
    context.reply(relay.getState());
});
