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

fn handleUserResponse() !void {
    std.log.info("Guess the number!", .{});
}

pub fn main() !void {
    const seed = try getSeed();
    const number = try getRandomNumber(seed);

    // test that the number is greater than 0 and exists

    std.debug.print("Random number: {}\n", .{number});

    try handleUserResponse();
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
