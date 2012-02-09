describe("wall", function() {

  var retroBoard = retro();

  it("should create a post it with id", function() {
    var jpostIt = {text: 'some text'};
    var id = retroBoard.create(jpostIt);
    var postIt = retroBoard.postIts[id];
    expect(postIt.id).toEqual(id);
    expect(postIt.text).toEqual('some text');
  });

  it("should create two post its with different ids", function() {
    var id1 = retroBoard.create({});
    var id2 = retroBoard.create({});
    expect(id1).not.toEqual(id2);
  });

  it("should update a post it", function() {
    var id = retroBoard.create({});
    var postIt = {id: id, text: 'updated post it'};
    retroBoard.update(postIt);
    expect(retroBoard.postIts[id].text).toEqual('updated post it');
  });

  it("should update a post it calling ui callback", function()  {
    var callback = jasmine.createSpy();
    var retroBoard = retro(callback);
    var id = retroBoard.create({});
    var postIt = {id: id, text: 'updated post it'};
    retroBoard.update(postIt);
    expect(retroBoard.postIts[id].text).toEqual('updated post it');
    expect(callback).toHaveBeenCalledWith(postIt);
  });
});
