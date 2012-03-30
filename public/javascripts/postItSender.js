var postItSender = function(name) {
  var client = new Faye.Client("/faye");

  var subscribe = function(updateCallback) {
    client.subscribe("/board/" + name, updateCallback);
  };

  var send = function(message) {
    client.publish("/board/" + name, message);
  };

  return {
    send: send,
    subscribe: subscribe
  };
};
