var postItSender = function(adapter) {
  var client = new Faye.Client("/faye");

  client.subscribe("/board", adapter.update);

  var send = function(postIt) {
    client.publish("/board", postIt);
  };

  return {
    send: send
  };
};
