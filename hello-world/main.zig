const std = @import("std");

fn wow() void {
    std.debug.print("Wow", .{});
}

pub fn main() void {
    std.debug.print("Hello World!\nThis is another message!\n", .{});
    wow();
}
