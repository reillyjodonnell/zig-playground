const expect = @import("std").testing.expect;

test "if statement" {
    const a = true;
    var b: u3 = 0;
    if (a) {
        b = 1;
    } else {
        b = 2;
    }

    try expect(b == 1);
}
