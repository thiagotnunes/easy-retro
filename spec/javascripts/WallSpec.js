describe("Wall", function() {
  it("should add post it with given text", function() {
    loadFixtures("wall.html");
    wall().bindButtons();
    $("#add_post_it").click();
    expect($("#post_it")).toBeVisible();
  });
});
