const std = @import("std");

pub fn main() !void {
    const a = [_]i32{ 1, 2, 3, 4, 5 };
    var end: usize = 4;
    const b = a[1..end];

    // b has both a len and a pointer
    std.debug.print("{*}\n", .{&b.len});
    std.debug.print("{*}\n", .{&b.ptr});
    std.debug.print("b: {*}\n", .{&b});
}
