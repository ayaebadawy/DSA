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

//121. Best Time to Buy and Sell Stock
// https://leetcode.com/problems/best-time-to-buy-and-sell-stock/description/
func maxProfit(_ prices: [Int]) -> Int {
    var l = 0, maxProf = 0
    for r in 0..<prices.count {
        while prices[l] > prices[r] { // no profit, contract window
            l += 1
        }
        maxProf = max(maxProf, prices[r] - prices[l])
    }
    return maxProf
}

//424. Longest Repeating Character Replacement
//https://leetcode.com/problems/longest-repeating-character-replacement/description/
func characterReplacement(_ s: String, _ k: Int) -> Int {
    var maxLen = 0, l = 0,  dict = [Character: Int]()
    let s = Array(s)
    for r in 0..<s.count {
        dict[s[r], default: 0] += 1
        while (r-l+1) - (dict.values.max() ?? 0) > k { //while invalid, contract the window, window len - the most repeated char which results in the number of char we need to flip ans then check that againest k
            dict[s[l], default: 0] -= 1
            l += 1
        }
        maxLen = max(maxLen, r-l+1)
    }
    return maxLen
}
