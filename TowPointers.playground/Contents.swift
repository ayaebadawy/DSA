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
