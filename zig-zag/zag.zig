const std = @import("std");

pub fn main() !void {
	const stdout = std.io.getStdOut().writer();
	var i: usize = 1;
	while(i <= 16) : (i += 1) {
		try stdout.print("{d}\n", .{i});

	}





}
