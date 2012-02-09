var retro = function(uiCallback) {
  var postIts = []; 

  var create = function(postIt) {
    var id = generateId();
    postIt.id = id;
    postIts[id] = postIt;
    return id;
  };

  var update = function(postIt) {
    postIts[postIt.id] = postIt;
    if (uiCallback) {
      uiCallback(postIt);
    }
  };

  var generateId = function() {
    return Date.now() + Math.floor(Math.random()*50);
  };

  return {
    postIts: postIts,
    create: create,
    update: update
  }
};
