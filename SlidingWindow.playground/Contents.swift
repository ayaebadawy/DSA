import Foundation

//1004. Max Consecutive Ones III
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
