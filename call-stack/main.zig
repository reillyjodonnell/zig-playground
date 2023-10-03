const std = @import("std");

pub fn main() void {
    var user1 = User.init(1, 10);
    var user2 = User.init(2, 20);

    // we expect 10 and 20
    std.debug.print("User {d} has power of {d}\n", .{ user1.id, user1.power });
    std.debug.print("User {d} has power of {d}\n", .{ user2.id, user2.power });

    // we get 20 and 20!!
    const userSize = @sizeOf(User);
    std.debug.print("User size: {any}\n", .{userSize});
}

pub const User = struct {
    id: u64,
    power: i32,

    // This is a dangling pointer and is the source of many segfault bugs
    // Solution instead of "power: i32) *User {" and "return &user"
    //  just return the User value not the pointer / address.
    fn init(id: u64, power: i32) User {
        var user = User{
            .id = id,
            .power = power,
        };
        return user;
    }
};
