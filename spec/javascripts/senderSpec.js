var Faye;

describe("Sender", function() {
  var sender;
  var adapter;
  var subscribe = jasmine.createSpy();
  var publish;
  
  beforeEach(function() { 
    adapter = { update: jasmine.createSpy() };
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
    sender = postItSender(adapter);
  });

  it("should subscribe to board channel", function() {
    expect(subscribe).toHaveBeenCalledWith("/board", adapter.update);
  });

  it("should send a message to the client", function() {
    var postIt = {id: 123};
    sender.send(postIt);
    expect(publish).toHaveBeenCalledWith("/board", postIt);
  });
});
