const std = @import("std");

pub fn main() !void {
    var file = try std.fs.cwd().openFile("2021/day02/input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [10]u8 = undefined;
    var commands: [1000][9:0]u8 = undefined;

    var i: u32 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| : (i += 1) {
        @memcpy((&commands[i])[0..line.len], line[0..line.len]);
    }

    // Part 1
    var forward: u32 = 0;
    var up: u32 = 0;
    for (commands) |command| {
        var args = std.mem.split(u8, &command, " ");
        if (std.mem.orderZ(u8, args.next().?.ptr, "forward").compare(std.math.CompareOperator.eq)) {
            forward += std.fmt.parseInt(u32, args.next(), 10);
            continue;
        }
        if (std.mem.orderZ(u8, args.next(), "forward").compare(std.math.CompareOperator.eq)) {
            up += std.fmt.parseInt(u32, args.next(), 10);
            continue;
        }
        if (std.mem.orderZ(u8, args.next(), "down").compare(std.math.CompareOperator.eq)) {
            up -= std.fmt.parseInt(u32, args.next(), 10);
            continue;
        }
    }

    std.debug.print("Part 1: {}\n", .{forward * up});

    // Part 2
}
