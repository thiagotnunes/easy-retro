var retro = function(sender) {

  var create = function(postIt) {
    postIt.id = generateId();
    sender.send(postIt);
    return postIt;
  };

  var generateId = function() {
    return Date.now() + '_' + Math.floor(Math.random()*50);
  };

  return {
    create: create
  };
};
