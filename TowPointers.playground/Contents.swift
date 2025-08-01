import Foundation

// 283. Move Zeroes
func moveZeroes(_ nums: inout [Int]) {
    var l = 0
    for r in 0..<nums.count {
        if nums[r] != 0  {
            nums.swapAt(l, r)
            l += 1
        }
    }
}
var grid = [0,1,0,3,12]
moveZeroes(&grid)

// 15. 3Sum
// https://leetcode.com/problems/3sum/description/
func threeSum(_ nums: [Int]) -> [[Int]] {
    let nums = nums.sorted()
    var res = Set<[Int]>()
    for i in 0..<nums.count {
        var l = i+1, r = nums.count - 1
        while l < r {
            let sum = nums[i] + nums[l] + nums[r]
            if sum == 0 {
                res.insert([nums[i], nums[l], nums[r]])
                l += 1
                r -= 1
            } else if sum < 0 {
                l += 1
            } else {
                r -= 1
            }
        }
    }
    return Array(res)
}

