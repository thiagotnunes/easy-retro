var postItSender = function() {
  var client = new Faye.Client("/faye");

  var subscribe = function(updateCallback) {
    client.subscribe("/board", updateCallback);
  };

  var send = function(postIt) {
    var publication = client.publish("/board", postIt);
    publication.callback(function() { alert('Success'); });
    publication.errback(function() { alert('Error'); });
  };

  return {
    send: send,
    subscribe: subscribe
  };
};
