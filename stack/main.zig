const std = @import("std");
const print = std.debug.print;

const AllocationError = error{
    OutOfMemory,
};

const Stack = struct {
    items: []u8,
    pos: usize,
    allocator: std.mem.Allocator,

    fn init(allocator: std.mem.Allocator) !Stack {
        var stack = .{ .pos = 0, .items = try allocator.alloc(u8, 20), .allocator = allocator };
        return stack;
    }

    fn deinit(self: *Stack) void {
        self.allocator.free(self.items);
    }

    fn push(self: *Stack, item: u8) !void {
        if (self.pos == self.items.len) {
            // Allocate new space double the size
            const newSlice = try self.allocator.alloc(u8, self.items.len * 2);

            // Copy the old items to the new space
            std.mem.copy(u8, newSlice[0..self.pos], self.items[0..self.pos]);

            // Deallocate the old space
            self.allocator.free(self.items);

            // Update the items pointer to the new space
            self.items = newSlice;
        }
        self.items[self.pos] = item;
        self.pos = self.pos + 1;
    }

    fn pop(self: *Stack) void {
        self.pos = self.pos - 1;
    }

    fn length(self: *Stack) usize {
        return self.pos;
    }

    fn peek(self: *Stack) u8 {
        return self.items[self.pos];
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var myStack = try Stack.init(allocator);
    defer myStack.deinit();

    print("length: {}\n", .{myStack.items.len});

    for (0.., myStack.items.len) |i, elem| {
        _ = elem;
        print("item: {any}\n", .{i});
    }
}

const expect = std.testing.expect;

test "struct" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var myStack = try Stack.init(allocator);
    defer myStack.deinit();
    try myStack.push(1);
    try myStack.push(2);
    myStack.pop();
    try expect(myStack.length() == 1);

    myStack.pop();
    try expect(myStack.length() == 0);
}

test "struct peek" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var myStack = try Stack.init(allocator);
    defer myStack.deinit();
    try myStack.push(1);
    try myStack.push(2);
    myStack.pop();
    const topItem = myStack.peek();
    try expect(topItem == 2);
}
