const std = @import("std");
const expect = @import("std").testing.expect;

fn increment(x: *i32) void {
    x.* += 1;
}

pub fn main() !void {
    var x: i32 = 0;
    increment(&x);
    std.debug.print("x: {}\n", .{&x});
    // check value of x
    if (x == 1) {
        std.debug.print("x == 1\n", .{});
    } else {
        std.debug.print("x != 1\n", .{});
    }
}
