var postItSender = function() {
  var client = new Faye.Client("/faye");
  client.disable('websocket');

  var subscribe = function(updateCallback) {
    client.subscribe("/board", updateCallback);
  };

  var send = function(postIt) {
    client.publish("/board", postIt);
  };

  return {
    send: send,
    subscribe: subscribe
  };
};
