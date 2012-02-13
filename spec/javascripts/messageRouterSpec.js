describe("Message Router", function() {

  var adapter;
  var router;

  beforeEach(function() {
    adapter = { create: jasmine.createSpy() };
    router = messageRouter(adapter);
  });

  it("should raise an error when message is not defined", function() {
    try {
      router.route();
    } catch(e) {
      expect(e.name).toBe("InvalidMessageException");
    }
  });

  it("should raise an error when there is no action associated", function() {
    try {
      router.route({});
    } catch(e) {
      expect(e.name).toBe("InvalidMessageException");
    }
  });

  it("should raise an error when the action has no mapping associated", function() {
    try {
      router.route({action: "invalidAction"});
    } catch(e) {
      expect(e.name).toBe("InvalidActionException");
    }
  });

  it("should create a post it for create action", function() {
    var message = { action: "create" };

    router.route(message);

    expect(adapter.create).toHaveBeenCalledWith(message);
  });

});
