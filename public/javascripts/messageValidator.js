var messageValidator = function(routes) {

  var invalidMessageException = function() {
    return { 
        name: "InvalidMessageException", 
        message: "The message is invalid"
      };
  };

  var noActionException = function() {
    return { 
        name: "NoActionException", 
        message: "An action must be defined for routing the message"
      };
  };

  var noBoardException = function() {
    return {
      name: "NoBoardException",
      message: "A board must be defined within the message"
    }
  };

  var noPostItException = function() {
    return {
      name: "NoPostException",
      message: "A post it must be defined within the message"
    }
  };

  var isInvalid = function(message) {
    return !message;
  };

  var hasNoAction = function(message) {
    return !message.action;
  };

  var hasNoBoard = function(message) {
    return !message.board;
  };

  var hasNoPostItIn = function(message) {
    return !message.board.post_it;
  };

  var validate = function(message) {
    if (isInvalid(message))
      throw invalidMessageException();

    if (hasNoAction(message))
      throw noActionException();

    if (hasNoBoard(message))
      throw noBoardException()

    if (hasNoPostItIn(message))
        throw noPostItException();
  };

  return {
    validate: validate
  };

};
