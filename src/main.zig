const std = @import("std");

pub fn main() !void {

    // Start timing
    const start_time: i128 = std.time.nanoTimestamp();

    // Action
    var arr = [100]i32{ 252, 65, 401, 100, 307, 996, 670, 591, 690, 817, 930, 483, 946, 234, 887, 82, 590, 737, 78, 156, 467, 452, 848, 105, 752, 536, 218, 890, 665, 703, 842, 892, 624, 36, 424, 755, 250, 230, 635, 764, 855, 26, 204, 958, 378, 742, 877, 528, 587, 341, 581, 539, 611, 956, 93, 90, 914, 631, 63, 197, 345, 208, 49, 557, 804, 647, 621, 929, 522, 22, 233, 819, 513, 784, 852, 870, 644, 358, 37, 67, 352, 889, 518, 964, 374, 614, 944, 997, 343, 563, 538, 568, 265, 775, 777, 519, 290, 504, 575, 835 };
    const target = 401;
    const sortingResult: SortingResult = bubbleSortAnalysis(arr[0..]);
    const searchResult: SearchResult = binarySearch(arr[0..], target);

    // End timing
    const end_time: i128 = std.time.nanoTimestamp();
    const elapsed_time_ns: i128 = end_time - start_time;
    const elapsed_time_s = @as(f64, @floatFromInt(elapsed_time_ns)) / 1_000_000_000.0;

    // Print

    std.debug.print("-- Sorting --\n", .{});
    std.debug.print("Array: {any}\n", .{sortingResult.arr});
    std.debug.print("Passes: {d}\n", .{sortingResult.passes});
    std.debug.print("Swaps: {d}\n", .{sortingResult.swaps});
    std.debug.print("-- Searching --\n", .{});
    std.debug.print("Found: {}\n", .{searchResult.isFound});
    std.debug.print("At Index: {?}\n", .{searchResult.atIndex});
    std.debug.print("Nbr of halves: {?}\n", .{searchResult.halves});
    std.debug.print("-- Metrics --\n", .{});
    std.debug.print("Time elapsed: {} ns ({d:.6} s)\n", .{
        elapsed_time_ns,
        elapsed_time_s,
    });
}
// ---------------------------------------------------------------
// Data Type: Array.
// Algorithm Type: Sorting
// ---------------------------------------------------------------
const SortingResult = struct {
    arr: []const i32,
    passes: usize,
    swaps: usize,
};

pub fn bubbleSort(arr: []i32) void {
    for (0..arr.len) |i| {
        for (0..arr.len - 1 - i) |j| {
            if (arr[j] > arr[j + 1]) {
                const temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

pub fn bubbleSortAnalysis(arr: []i32) SortingResult {
    var passes: usize = 0;
    var swaps: usize = 0;
    var swapped: bool = true;

    while (swapped) {
        swapped = false;
        passes += 1;

        for (0..arr.len - passes) |j| {
            if (arr[j] > arr[j + 1]) {
                const temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;

                swaps += 1;
                swapped = true;
            }
        }
    }

    return SortingResult{
        .arr = arr,
        .passes = passes,
        .swaps = swaps,
    };
}
// ---------------------------------------------------------------
// Data Type: Array.
// Algorithm Type: Searching
// ---------------------------------------------------------------
const SearchResult = struct { isFound: bool, atIndex: ?usize, halves: ?usize };

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
        .halves = null,
    };
}

pub fn recursiveBinarySearch(sortedArr: []const i32, target: i32, low: usize, high: usize) SearchResult {
    var halved: usize = 0;

    if (low > high) {
        return SearchResult{
            .isFound = false,
            .atIndex = null,
            .halves = halved,
        };
    }

    const mid = low + (high - low) / 2;
    halved += 1;

    if (sortedArr[mid] == target) {
        return SearchResult{
            .isFound = true,
            .atIndex = mid,
            .halves = halved,
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
    var halved: usize = 0;

    while (low <= high) {
        const mid = low + (high - low) / 2;
        const value = sortedArr[mid];
        halved += 1;

        if (value == target) {
            return SearchResult{
                .isFound = true,
                .atIndex = mid,
                .halves = halved,
            };
        } else if (mid == low or mid == high) {
            return SearchResult{
                .isFound = false,
                .atIndex = null,
                .halves = halved,
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
        .halves = halved,
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
