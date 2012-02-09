var retro = function(uiAdapter) {
  var postIts = []; 

  var create = function(postIt) {
    var id = generateId();
    postIt.id = id;
    postIts[id] = postIt;

    return id;
  };

  var update = function(postIt) {
    postIts[postIt.id] = postIt;
    uiAdapter.update(postIt);
  };

  var getPostIt = function(id) {
    return postIts[id];
  };

  var generateId = function() {
    return Date.now() + Math.floor(Math.random()*50);
  };

  return {
    getPostIt: getPostIt,
    create: create,
    update: update
  };
};
