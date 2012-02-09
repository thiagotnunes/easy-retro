describe("retro", function() {

  var sender;
  var retroBoard;

  beforeEach(function() {
    sender = { send: jasmine.createSpy() };
    retroBoard = retro(sender);
  });

  it("should create a post it with id", function() {
    var jpostIt = {text: 'some text'};
    var postIt = retroBoard.create(jpostIt);

    expect(postIt.id).toBeDefined();
    expect(postIt.text).toEqual('some text');
  });

  it("should create two post its with different ids", function() {
    var id1 = retroBoard.create({}).id;
    var id2 = retroBoard.create({}).id;

    expect(id1).not.toEqual(id2);
  });

  it("should send the newly created post it to others", function() {
    var postIt = retroBoard.create({group: 'well'});

    expect(sender.send).toHaveBeenCalledWith(postIt);
  });
});
