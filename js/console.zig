const std = @import("std");

pub export fn console(text: [*c]const u8) void {
    var stdout = std.io.getStdOut().writer();
    // Assuming text is null-terminated, calculate the length up to the null terminator
    const len = std.mem.len(text) - 1; // Subtract 1 to exclude the null terminator from the length
    _ = stdout.write(text[0..len]) catch {
        // Handle or log the error
        return;
    };
}

pub fn main() !void {
    console("Hello world!");
}

test "huh" {
    console("Hello world!");
    // read from std out

}
