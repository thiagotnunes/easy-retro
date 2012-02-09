var retro = function(uiAdapter) {
  var postIts = []; 

  var create = function(postIt) {
    var id = generateId();
    
    postIt.id = id;
    update(postIt);

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
    return Date.now() + '_' + Math.floor(Math.random()*50);
  };

  return {
    getPostIt: getPostIt,
    create: create,
    update: update
  };
};
