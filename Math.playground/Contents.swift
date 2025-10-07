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
