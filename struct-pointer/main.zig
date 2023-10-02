const std = @import("std");

pub fn main() void {
    var user = User{
        .id = 1,
        .power = 100,
    };

    user.levelUp();

    std.debug.print("user: {*}\nuser.id: {*}\nuser.power: {*}\n", .{ &user, &user.id, &user.power });
}

pub const User = struct {
    id: u64,
    power: i32,
    fn levelUp(user: *User) void {
        std.debug.print("pointertopointer: {*}\npointer to user: {*}\n", .{ &user, user });
        user.power += 1;
    }
};
