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

//1. Two Sum
//https://leetcode.com/problems/two-sum/description/
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()
    for (i, n) in nums.enumerated() {
        if let index = dict[target-n] { return [i, index] }
        dict[n] = i
    }
    return []
}
twoSum([2,7,11,15], 9)

//49. Group Anagrams
//https://leetcode.com/problems/group-anagrams/description/
func groupAnagrams(_ strs: [String]) -> [[String]] {
    var dict = [String: [String]]() //sorted char of anagrams, string
    for s in strs {
        let sorted = String(s.sorted())
        dict[sorted, default: []].append(s)
    }
    return Array(dict.values)
}

//https://leetcode.com/problems/encode-and-decode-strings/description/
//

//347. Top K Frequent Elements (Bucket sort) Time O(n)
//https://leetcode.com/problems/top-k-frequent-elements/description/
func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var dict = [Int: Int]() //num: count
    var bucket: [[Int]] = Array(repeating: [], count: nums.count + 1) // index = count, values = elements
    var res = [Int]()
    for n in nums {
        dict[n, default: 0] += 1
    }
    for (key, value) in dict {
        bucket[value].append(key)
    }
    for i in stride(from: bucket.count - 1, to: 0, by: -1) {
        res.append(contentsOf: bucket[i])
        if res.count == k { break }
    }
    return res
}

//36. Valid Sudoku Time O(n^2)
// https://leetcode.com/problems/valid-sudoku/description/
func isValidSudoku(_ board: [[Character]]) -> Bool {
    var dictRow = [Int: [Character]]()
    var dictCol = [Int: [Character]]()
    var dictSqr = [String: [Character]]()
    for r in 0..<board.count {
        for c in 0..<board[0].count {
            let cur = board[r][c]
            if cur == "." { continue }
            if dictRow[r, default: []].contains(cur) ||
                dictCol[c, default: []].contains(cur) ||
                dictSqr[String(r/3) + String(c/3), default: []].contains(cur) {
                return false
            } else {
                dictRow[r, default: []].append(cur)
                dictCol[c, default: []].append(cur)
                dictSqr[String(r/3) + String(c/3), default: []].append(cur)
            }
        }
    }
    return true
}

//238. Product of Array Except Self
//https://leetcode.com/problems/product-of-array-except-self/description/
func productExceptSelf(_ nums: [Int]) -> [Int] {
    var res = Array(repeating: 1, count: nums.count)
    var prefix = 1, postfix = 1
    for (i,n) in nums.enumerated() {
        res[i] = prefix
        prefix *= nums[i]
    }
    for i in stride(from: nums.count - 1, through: 0, by: -1) {
        res[i] *= postfix
        postfix *= nums[i]
    }
    return res
}

productExceptSelf([1,2,3,4])

//128. Longest Consecutive Sequence
//https://leetcode.com/problems/longest-consecutive-sequence/description/
func longestConsecutive(_ nums: [Int]) -> Int {
    var longest = 0
    let nums = Set(nums)
    for n in nums {
        if !nums.contains(n-1) { // the begining of a seq
            var cur = n
            var curSeq = 1
            while nums.contains(cur+1) {
                curSeq += 1
                cur += 1
            }
            longest = max(longest, curSeq)
        }
    }
    return longest
}
