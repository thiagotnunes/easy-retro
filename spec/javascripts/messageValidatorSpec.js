describe("Message validator", function() {

  var validator;

  beforeEach(function() {
    var routes = { create: function() {} };
    validator = messageValidator(routes);
  });

  it("should raise an error when message is not defined", function() {
      expect(validator.validate).toThrow({ 
        name: "InvalidMessageException",
        message: "An action must be defined for routing the message"
      });
  });

  it("should raise an error when there is no action associated", function() {
    expect(validator.validate).toThrow({ 
      name: "InvalidMessageException",
      message: "An action must be defined for routing the message"
    });
  });

  it("should raise an error when there is no postIt in the message", function() {
    expect(function() { validator.validate({ action: "create" }) }).toThrow({
      name: "NoPostItException",
      message: "A post it must be defined within the message"
    });
  });
});
