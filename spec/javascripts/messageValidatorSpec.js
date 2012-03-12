describe("Message validator", function() {

  var validator;

  beforeEach(function() {
    var routes = { create: function() {} };
    validator = messageValidator(routes);
  });

  it("should raise an error when message is not defined", function() {
      expect(validator.validate).toThrow({ 
        name: "InvalidMessageException",
        message: "The message is invalid"
      });
  });

  it("should raise an error when there is no action associated", function() {
    expect(function() { validator.validate({}) }).toThrow({ 
      name: "InvalidMessageException",
      message: "An action must be defined for routing the message"
    });
  });

  it("should raise an error when there is no board in the message", function() {
    expect(function() { validator.validate({ action: "create"})}).toThrow({
name: "NoBoardException",
message: "A board must be defined within the message"
      }
    );
  });
  

  it("should raise an error when there is no post it in the message", function() {
    expect(function() { validator.validate({ action: "create", board: {} }) }).toThrow({
      name: "NoPostItException",
      message: "A post it must be defined within the message"
    });
  });

  it("should not raise any error when message is well formed", function() {
      validator.validate({ action: "create", board: { name: "theBoard", post_it: { id: "1", text: "text" } } });
  });
  
});
