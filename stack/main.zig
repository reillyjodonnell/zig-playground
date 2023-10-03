const std = @import("std");
const print = std.debug.print;

const Stack = struct {
    items: []u8,
    pos: usize,
    allocator: std.mem.Allocator,

    fn init(allocator: std.mem.Allocator) !Stack {
        var stack = .{ .pos = 0, .items = try allocator.alloc(u8, 20), .allocator = allocator };
        return stack;
    }

    fn deinit(self: Stack) void {
        self.allocator.free(self.items);
    }

    fn push(self: *Stack, item: u8) void {
        self.items[self.pos] = item;
        self.pos = self.pos + 1;
    }

    fn pop(self: *Stack) void {
        self.pos = self.pos - 1;
    }

    fn length(self: *Stack) usize {
        return self.pos;
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var myStack = try Stack.init(allocator);
    defer myStack.deinit();
    myStack.push(1);
    myStack.push(2);

    print("length: {}\n", .{myStack.items.len});

    for (myStack.items[0..myStack.pos]) |item| {
        print("item: {}\n", .{item});
    }
}

const expect = std.testing.expect;

test "struct" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var myStack = try Stack.init(allocator);
    defer myStack.deinit();
    myStack.push(1);
    myStack.push(2);
    myStack.pop();
    try expect(myStack.length() == 1);
}
