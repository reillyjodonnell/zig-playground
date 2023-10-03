const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn main() !void {}

fn List(comptime T: type) type {
    return struct {
        pos: usize,
        items: []T,
        allocator: Allocator,

        fn init(allocator: Allocator) !List(T) {
            return .{ .pos = 0, .allocator = allocator, .items = try allocator.alloc(T, 4) };
        }
    };
}
