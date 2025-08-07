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
containsDuplicate([1,2,3,1])

//242. Valid Anagram
//https://leetcode.com/problems/valid-anagram/description/
func isAnagram(_ s: String, _ t: String) -> Bool {
    var sDict = [Character: Int](), tDict = [Character: Int]()
    for char in s {
        sDict[char, default: 0] += 1
    }
    for char in t {
        tDict[char, default: 0] += 1
    }
    return sDict == tDict
}
isAnagram("anagram", "nagaram")
