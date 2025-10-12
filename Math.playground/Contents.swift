import Foundation

//70. Climbing Stairs    fibinacci series
//https://leetcode.com/problems/climbing-stairs/description/
func climbStairs(_ n: Int) -> Int {
    if n <= 2 { return n }
    var first = 1, sec = 2
    for _ in 3...n {
        let third = first + sec
        first = sec
        sec = third
    }
    return sec
}

//48. Rotate Image   Time O(n2) as we process all elements in the matrix nxn
//https://leetcode.com/problems/rotate-image/
func rotate(_ matrix: inout [[Int]]) {
    var l = 0, r = matrix.count - 1
    while l < r {
        for i in 0..<r-l {
            //current window of elements is r - l + 1 but we do not need to process the last corner already processed hints r - l
            var top = l, bottom = r
            let topLeft = matrix[top][l + i]
            matrix[top][l + i] = matrix[bottom - i][l]
            matrix[bottom - i][l] = matrix[bottom][r - i]
            matrix[bottom][r - i] = matrix[top + i][r]
            matrix[top + i][r] = topLeft
        }
        l += 1
        r -= 1
    }
}
