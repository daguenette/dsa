const std = @import("std");

pub fn main() !void {

    // Start timing
    const start_time: i128 = std.time.nanoTimestamp();

    // Action
    const arr = [18]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 };
    const target = 7;
    const result: SearchResult = binarySearch(&arr, target);

    // End timing
    const end_time: i128 = std.time.nanoTimestamp();
    const elapsed_time_ns: i128 = end_time - start_time;
    const elapsed_time_s = @as(f64, @floatFromInt(elapsed_time_ns)) / 1_000_000_000.0;

    // Print
    std.debug.print("Found: {}\n", .{result.isFound});
    std.debug.print("At Index: {?}\n", .{result.atIndex});
    std.debug.print("Time elapsed: {} ns ({d:.6} s)\n", .{
        elapsed_time_ns,
        elapsed_time_s,
    });
}

// ---------------------------------------------------------------
// Data Type: Array.
// Algorithm: Linear Search | Binary Search
// ---------------------------------------------------------------
const SearchResult = struct { isFound: bool, atIndex: ?usize };

pub fn simpleLinearSearch(arr: []const []const u8, term: []const u8) bool {
    for (arr, 0..) |elem, index| {
        if (std.mem.eql(u8, elem, term)) {
            return SearchResult{
                .isFound = true,
                .atIndex = index,
            };
        }
    }
    return SearchResult{
        .isFound = false,
        .atIndex = null,
    };
}

pub fn recursiveBinarySearch(sortedArr: []const i32, target: i32, low: usize, high: usize) SearchResult {
    if (low > high) {
        return SearchResult{
            .isFound = false,
            .atIndex = null,
        };
    }

    const mid = low + (high - low) / 2;

    if (sortedArr[mid] == target) {
        return SearchResult{
            .isFound = true,
            .atIndex = mid,
        };
    } else if (sortedArr[mid] > target) {
        return recursiveBinarySearch(sortedArr, target, low, mid - 1);
    } else {
        return recursiveBinarySearch(sortedArr, target, mid + 1, high);
    }
}

pub fn binarySearch(sortedArr: []const i32, target: i32) SearchResult {
    var low: usize = 0;
    var high: usize = sortedArr.len - 1;

    while (low <= high) {
        const mid = low + (high - low) / 2;
        const value = sortedArr[mid];

        if (value == target) {
            return SearchResult{
                .isFound = true,
                .atIndex = mid,
            };
        } else if (value > target) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return SearchResult{
        .isFound = false,
        .atIndex = null,
    };
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
