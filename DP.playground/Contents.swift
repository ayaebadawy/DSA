import Foundation

// 338. Counting Bits
//https://leetcode.com/problems/counting-bits/description/?envType=company&envId=facebook&favoriteSlug=facebook-thirty-days
func countBits(_ n: Int) -> [Int] {
    var dp = Array(repeating: 0, count: n + 1)
    var offset = 1
    for i in 1..<n+1 {
        if offset * 2 == i { offset = i }
        dp[i] = 1 + dp[i - offset]
    }
    return dp
}

countBits(5)
