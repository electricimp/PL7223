#require "rocky.class.nut:1.1"
#require "messagemanager.class.nut:1.0.2"

mm <- MessageManager();
api <- Rocky();

// converts watt seconds to kilowatt hours
function wattSecondsToKiloWattHours(ws) {
  return (ws * 1.0)/(3600000.0);
}

// Get the KWH since reset
api.get("/power", function(context) {
  mm.send("getPower", null)
    .onReply(function(msg, reply) {
      local kwh = wattSecondsToKiloWattHours(reply)
      context.send({ power = kwh });
    });
});

// Reset the power counter
api.get("/power/reset", function(context) {
  mm.send("resetPower", null)
    .onReply(function(msg, reply) {
      local kwh = wattSecondsToKiloWattHours(reply)
      context.send({ power = kwh });
    });
});

// returns the current state
api.get("/state", function(context) {
  mm.send("getState", null)
    .onReply(function(msg, reply) {
      context.send({ state = reply });
    });
});

// turns device on, and returns state
api.get("/state/on", function(context) {
  mm.send("setState", 1)
    .onReply(function(msg, reply) {
      context.send({ state = reply });
    });
});

// turns device off, and returns state
api.get("/state/off", function(context) {
  mm.send("setState", 0)
    .onReply(function(msg, reply) {
      context.send({ state = reply });
    });
});
