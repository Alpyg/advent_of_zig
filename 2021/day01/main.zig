const std = @import("std");

pub fn main() !void {
    var file = try std.fs.cwd().openFile("2021/day01/input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [5]u8 = undefined;
    var measurements: [2000]u32 = undefined;

    var i: u32 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| : (i += 1) {
        measurements[i] = try std.fmt.parseInt(u32, line, 10);
    }

    // Part 1
    var increases: u32 = 0;
    var previous: u32 = 0;
    for (measurements) |current| {
        if (current > previous) {
            increases += 1;
        }
        previous = current;
    }

    std.debug.print("Part 1: {}\n", .{increases - 1}); // -1 for the first measurement

    // Part 2
    increases = 0;
    previous = 0;
    i = 2;
    while (i < 2000) : (i += 1) {
        var current = measurements[i - 2] + measurements[i - 1] + measurements[i];
        if (current > previous) {
            increases += 1;
        }
        previous = current;
    }

    std.debug.print("Part 2: {}\n", .{increases - 1});
}
