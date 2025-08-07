import Foundation

//217. Contains Duplicate
//https://leetcode.com/problems/contains-duplicate/
func containsDuplicate(_ nums: [Int]) -> Bool {
    var dict: [Int: Int] = [:] // key: num, value: count
    for n in nums {
        if let num = dict[n] { return true }
        dict[n, default: 0] += 1
    }
    return false
}
