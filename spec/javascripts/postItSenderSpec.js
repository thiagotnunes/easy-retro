var Faye;

describe("Sender", function() {
  var sender;
  var updateCallback;
  var subscribe;
  var publish;
  
  beforeEach(function() { 
    update = jasmine.createSpy();
    subscribe = jasmine.createSpy();
    publish = jasmine.createSpy();
    Faye = { 
      Client : function() { 
        return {
          subscribe: subscribe,
          publish: publish
        };
      }
    };
    sender = postItSender();
  });

  it("should subscribe to board channel", function() {
    sender.subscribe(updateCallback);

    expect(subscribe).toHaveBeenCalledWith("/board", updateCallback);
  });

  it("should send a message to the client", function() {
    var postIt = {id: 123};
    sender.send(postIt);
    expect(publish).toHaveBeenCalledWith("/board", postIt);
  });

});
