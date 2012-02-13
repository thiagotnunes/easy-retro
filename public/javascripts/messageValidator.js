var messageValidator = function(routes) {

  var invalidMessageException = function() {
    return { 
        name: "InvalidMessageException", 
        message: "An action must be defined for routing the message"
      };
  };

  var noPostItException = function() {
    return {
      name: "NoPostException",
      message: "A post it must be defined within the message"
    }
  };

  var isInvalid = function(message) {
    return !message || !message.action;
  };

  var hasNoPostItIn = function(message) {
    return !message.postIt;
  };

  var validate = function(message) {
    if (isInvalid(message))
      throw invalidMessageException();

    if (hasNoPostItIn(message))
        throw noPostItException();
  };

  return {
    validate: validate
  };

};
