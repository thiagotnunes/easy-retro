var postItSender = function() {
  var client = new Faye.Client("/faye");

  var subscribe = function(updateCallback) {
    client.subscribe("/board", updateCallback);
  };

  var send = function(message) {
    client.publish("/board", message);
  };

  return {
    send: send,
    subscribe: subscribe
  };
};
