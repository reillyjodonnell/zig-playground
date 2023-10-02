const std = @import("std");
const expect = @import("std").testing.expect;

fn getSeed() !u64 {
    const currentTime = std.time.timestamp();
    const seed: u64 = @bitCast(currentTime);
    return seed;
}

fn getRandomNumber(seed: u64) !u8 {
    var rand_impl = std.rand.DefaultPrng.init(seed);
    return @mod(rand_impl.random().int(u8), 100);
}

fn handleUserResponse(number: u8) !void {
    // keyboard input is emitted as an interrupt which the kernel handles
    // its then stored in the buffer which we can read from using the reader
    const in = std.io.getStdIn();
    var buf = std.io.bufferedReader(in.reader());
    // Get the Reader interface from BufferedReader
    var r = buf.reader();

    var correct = false;

    while (correct == false) {
        std.debug.print("Guess a number: ", .{});
        var msg_buf: [4096]u8 = undefined;
        var fbs = std.io.fixedBufferStream(&msg_buf);
        try r.streamUntilDelimiter(fbs.writer(), '\n', fbs.buffer.len);
        const guess = fbs.getWritten();

        const formattedGuess = std.fmt.parseInt(u8, guess, 10) catch |err| switch (err) {
            error.Overflow => {
                continue;
            },
            error.InvalidCharacter => {
                continue;
            },
        };

        if (formattedGuess == number) {
            std.debug.print("Correct!\n", .{});
            correct = true;
            return;
        }
        if (formattedGuess < number) {
            std.debug.print("It's higher. ", .{});
        }
        if (formattedGuess > number) {
            std.debug.print("It's lower. ", .{});
        }
        std.debug.print("Try again\n", .{});
    }
}

pub fn main() !void {
    const seed = try getSeed();
    const number = try getRandomNumber(seed);

    // test that the number is greater than 0 and exists

    std.debug.print("Random number: {}\n", .{number});

    try handleUserResponse(number);
}

test "test getSeed" {
    const seed = try getSeed();
    try expect(seed > 0);
}

test "test getRandomNumber" {
    const seed: u64 = 1789263;
    const number = try getRandomNumber(seed);
    try expect(number > 0);
}
