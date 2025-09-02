import Foundation

//1004. Max Consecutive Ones III
//https://leetcode.com/problems/max-consecutive-ones-iii/description/
func longestOnes(_ nums: [Int], _ k: Int) -> Int {
    var maxWindow = 0, numOfZeros = 0 , l = 0
    for r in 0..<nums.count {
        if nums[r] == 0 { numOfZeros += 1 }
        while numOfZeros > k {
            if nums[l] == 0 {
                numOfZeros -= 1
            }
            l += 1
        }
        maxWindow = max(maxWindow, (r-l+1))
    }
    return maxWindow
}

//3. Longest Substring Without Repeating Characters
//https://leetcode.com/problems/longest-substring-without-repeating-characters/description/
func lengthOfLongestSubstring(_ s: String) -> Int {
    var maxWindow = 0, l = 0, used = Set<Character>()
    let s = Array(s)
    for r in 0..<s.count {
        while used.contains(s[r]) { //invalid window, contract
            used.remove(s[l])
            l += 1
        }
        used.insert(s[r])
        maxWindow = max(maxWindow, r-l+1)
    }
    return maxWindow
}
