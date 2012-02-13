var messageRouter = function(validator, adapter) {

  var defaultRoutes = {
    create: adapter.create
  };

  var invalidActionException = function(action) {
    return {
      name: "InvalidActionException",
      message: "Action " + action + " has no corresponding mapping"
    }
  };

  var hasNoMappingFor = function(action) {
    return !defaultRoutes[action];
  };

  var route = function(message) {
    validator.validate(message);

    var action = message.action;

    if (hasNoMappingFor(action))
      throw invalidActionException(action);

    defaultRoutes[action](message.postIt);
  };

  return {
    route: route
  };
};
