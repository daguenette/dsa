const std = @import("std");

pub fn main() !void {
    const arr = [2][]const u8{ "Hello", "World" };
    const result: bool = simpleLinearSearch(&arr, "World");
    std.debug.print("{}\n", .{result});
}

// ---------------------------------------------------------------
// Data Type: Array.
// Algorithm: Linear Search
// ---------------------------------------------------------------
pub fn simpleLinearSearch(arr: []const []const u8, term: []const u8) bool {
    for (arr) |elem| {
        if (std.mem.eql(u8, elem, term)) {
            return true;
        }
    }
    return false;
}

// ---------------------------------------------------------------
// Data Type: Array.
// Algorithm: Find lowest number.
// ---------------------------------------------------------------
pub fn simpleFindLowestValue(arr: []const i32) i32 {
    var minVal: i32 = arr[0];
    for (arr) |elem| {
        if (elem <= minVal) {
            minVal = elem;
        }
    }
    return minVal;
}

// ---------------------------------------------------------------
// Example of For Loop vs. Recursion
// ---------------------------------------------------------------

pub fn simpleFibonacci(comptime length: usize) void {
    var fibonacciSequence: [length]i32 = undefined;
    fibonacciSequence[0..2].* = .{ 0, 1 };

    for (2..fibonacciSequence.len) |i| {
        fibonacciSequence[i] = fibonacciSequence[i - 2] + fibonacciSequence[i - 1];
    }

    for (fibonacciSequence, 0..) |value, i| {
        std.debug.print("Index {d}: {d}\n", .{ i, value });
    }
}

pub fn recursionFibonacci(prev1: i32, prev2: i32, count: usize, length: usize) void {
    if (count > length) return;

    const newFibo = prev1 + prev2;
    std.debug.print("{d}\n", .{newFibo});

    recursionFibonacci(newFibo, prev1, count + 1);
}
