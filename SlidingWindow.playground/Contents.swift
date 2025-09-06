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

//567. Permutation in String
//https://leetcode.com/problems/permutation-in-string/description/
func checkInclusion(_ s1: String, _ s2: String) -> Bool {
    if s1.count > s2.count { return false }
    let s1 = Array(s1), s2 = Array(s2)
    var dict1 = [Character: Int]() , dict2 = [Character: Int](), l = 0
    for c in s1 {
        dict1[c , default: 0] += 1
    }
    for r in 0..<s2.count {
        dict2[s2[r], default: 0] += 1
        if r >= s1.count { // when invalid, contract the window,we use if as it's a fixed window, not variable
            dict2[s2[l], default: 0] -= 1
            if dict2[s2[l]] == 0 { dict2[s2[l]] = nil }
            l += 1
        }
        if dict1 == dict2 { return true }
    }
    return false
}

//76. Minimum Window Substring
//https://leetcode.com/problems/minimum-window-substring/description/
func minWindow(_ s: String, _ t: String) -> String {
    if t.isEmpty { return "" }
    var dictT = [Character: Int](), dictS = [Character: Int]()
    for c in t {
        dictT[c, default: 0] += 1
    }
    var l = 0, have = 0, need = dictT.count, startIndex = 0, strLen = Int.max
    let s = Array(s)
    for r in 0..<s.count {
        dictS[s[r], default: 0] += 1
        if dictT[s[r]] == dictS[s[r]] { have += 1 }
        while have == need {
            if (r-l+1) < strLen {
                strLen = r-l+1
                startIndex = l
            }
            dictS[s[l], default: 0] -= 1
            if let count = dictT[s[l]], dictS[s[l]]! < count { have -= 1 }
            l += 1
        }
    }
    return strLen == Int.max ? "" : String(s[startIndex..<startIndex+strLen])
}

//239. Sliding Window Maximum   Time O(n)
//https://leetcode.com/problems/sliding-window-maximum/description/
//monotonically decreacing queue
func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    var res = [Int](), q = [Int](), l = 0
    
    for r in 0..<nums.count {
        while !q.isEmpty && nums[r] > nums[q.last!] {
            q.removeLast()
        }
        q.append(r)
        if l > q[0] { q.removeFirst() }
        if (r-l+1) == k {
            res.append(nums[q[0]])
            l += 1
        }
    }
    return res
}

//219. Contains Duplicate II   Time O(n)
//https://leetcode.com/problems/contains-duplicate-ii/description/
func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
    var l = 0, window = Set<Int>()
    for r in 0..<nums.count {
        if (r-l) > k {
            window.remove(nums[l])
            l += 1
        }
        if window.contains(nums[r]) { return true }
        window.insert(nums[r])
    }
    return false
}

//1343. Number of Sub-arrays of Size K and Average Greater than or Equal to Threshold
// https://leetcode.com/problems/number-of-sub-arrays-of-size-k-and-average-greater-than-or-equal-to-threshold/description/
func numOfSubarrays(_ arr: [Int], _ k: Int, _ threshold: Int) -> Int {
    var l = 0, numOfSubArr = 0, sum = 0
    for r in 0..<arr.count {
        sum += arr[r]
        if (r-l+1) > k {
            sum -= arr[l]
            l += 1
        }
        if (r-l+1) == k {
            if sum / k >= threshold { numOfSubArr += 1}
        }
    }
    return numOfSubArr
}
