var messageRouter = function(adapter) {

  var routes = {
    create: adapter.create
  };

  var invalidMessageException = function() {
    return { 
        name: "InvalidMessageException", 
        message: "An action must be defined for routing the message"
      };
  };

  var invalidActionException = function(action) {
    return {
      name: "InvalidActionException",
      message: "Action " + action + " has no corresponding mapping"
    }
  };

  var isInvalid = function(message) {
    return !message || !message.action;
  };

  var hasNoMappingFor = function(action) {
    return !routes[action];
  };

  var route = function(message) {
    if (isInvalid(message))
      throw invalidMessageException();

    var action = message.action;

    if (hasNoMappingFor(action))
      throw invalidActionException(action);

    routes[action](message);
  };

  return {
    route: route
  };
};
