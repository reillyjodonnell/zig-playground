const std = @import("std");
const print = std.debug.print;

const Stack = struct {
    const items: [100]u8 = undefined;
    fn push(item: u8) void {
        _ = item;
    }
};

pub fn main() !void {}

const expect = std.testing.expect;

test "struct" {
    const myStruct = Stack{};

    myStruct.push(2);

    expect(myStruct.length == 1);
}
