describe("Message Router", function() {

  var router;
  var validator;

  beforeEach(function() {
    adapter = { create: jasmine.createSpy() };
    validator = { validate: jasmine.createSpy() };
    var routes = {
      create: adapter.create
    };

    router = messageRouter(validator, routes);
  });

  it("should raise an error when the action has no mapping associated", function() {
    expect(function() { router.route({ action: "invalidAction" }) }).toThrow({ 
      name: "InvalidActionException",
      message: "Action invalidAction has no corresponding mapping"
    });
  });

  it("should create a post it for valid action", function() {
    var postIt = {};
    var message = { action: "create" , board: { post_it: postIt } };

    router.route(message);

    expect(validator.validate).toHaveBeenCalledWith(message);
    expect(adapter.create).toHaveBeenCalledWith(postIt);
  });

});
