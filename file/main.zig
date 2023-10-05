const std = @import("std");
const fs = std.fs;
const print = std.debug.print;

fn writeToFile(fileName: []const u8, text: []const u8) !void {
    const file = try fs.cwd().createFile(fileName, .{ .read = true });
    try file.writeAll(text);
    defer file.close();
    return;
}

fn readFromFile(fileName: []const u8) ![]const u8 {
    const file = try std.fs.cwd().openFile(fileName, .{});
    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);
    const text = buffer[0..bytes_read];
    print("{s}", .{text});
    return text;
}

pub fn main() !void {
    const fileName = "test.txt";
    try writeToFile(fileName, "Holy shit is this working?");
    const txt = try readFromFile(fileName);
    _ = txt;
}
