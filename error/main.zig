const Error = @import("std").builtin.Error;

const MyErrors = error{ OutOfMemory, InvalidInput, Error };

fn mayFail(shouldFail: bool) !void {
    if (shouldFail) return MyErrors.Error;
}

const std = @import("std");

pub fn main() !void {
    mayFail(true) catch |err| {
        switch (err) {
            MyErrors.OutOfMemory => std.debug.print("Out of memory.\n", .{}),
            MyErrors.InvalidInput => std.debug.print("Invalid input.\n", .{}),
            MyErrors.Error => std.debug.print("Unknown error.\n", .{}),
        }
        return;
    }; // This will propagate the error up the call stack.
    std.debug.print("We won't get here if there was an error.\n", .{});
}
