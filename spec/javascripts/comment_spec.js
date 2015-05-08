describe("App.getComments", function () {
  it("should return an array length of 2", function() {
    expect(App.getComments(1).length).toBe(2);
  });
});

describe("App.Popcorn", function () {
  test = new App.Popcorn("https://www.youtube.com/watch?v=hR_eQ3EqOvc", "#video", [])
  it("should have a popcorn object attribute", function () {
    expect(typeof test.video).toBe("object")
  });

  it("should have an array attribute", function () {
    expect(test.comments).toEqual([])
  });
});

