var messageRouter = function(validator, routes) {

  var invalidActionException = function(action) {
    return {
      name: "InvalidActionException",
      message: "Action " + action + " has no corresponding mapping"
    }
  };

  var hasNoMappingFor = function(action) {
    return !routes[action];
  };

  var route = function(message) {
    validator.validate(message);

    var action = message.action;

    if (hasNoMappingFor(action))
      throw invalidActionException(action);

    routes[action](message.board.postIt);
  };

  return {
    route: route
  };
};
