#require "rocky.class.nut:1.1"
#require "bullwinkle.class.nut:1.0"

bull <- Bullwinkle();
api <- Rocky();

// converts watt seconds to kilowatt hours
function wattSecondsToKiloWattHours(ws) {
  return (ws * 1.0)/(3600000.0);
}

// Get the KWH since reset
api.get("/power", function(context) {
  bull.send("getPower", null)
    .onreply(function(replyContext) {
      local kwh = wattSecondsToKiloWattHours(replyContext.reply)
      context.send({ power = kwh });
    });
});

// Reset the power counter
api.get("/power/reset", function(context) {
  bull.send("resetPower", null)
    .onreply(function(replyContext) {
      local kwh = wattSecondsToKiloWattHours(replyContext.reply)
      context.send({ power = kwh });
    });
});

// returns the current state
api.get("/state", function(context) {
  bull.send("getState", null)
    .onreply(function(replyContext) {
      context.send({ state = replyContext.reply });
    });
});

// turns device on, and returns state
api.get("/state/on", function(context) {
  bull.send("setState", 1)
    .onreply(function(replyContext) {
      context.send({ state = replyContext.reply });
    });
});

// turns device off, and returns state
api.get("/state/off", function(context) {
  bull.send("setState", 0)
    .onreply(function(replyContext) {
      context.send({ state = replyContext.reply });
    });
});
