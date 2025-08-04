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

//986. Interval List Intersections
// https://leetcode.com/problems/interval-list-intersections/description/?envType=company&envId=facebook&favoriteSlug=facebook-thirty-days
//Time O (N+M) size of 2 lists
func intervalIntersection(_ firstList: [[Int]], _ secondList: [[Int]]) -> [[Int]] {
    if firstList.isEmpty || secondList.isEmpty { return [] }
    var res = [[Int]](), i = 0, j = 0
    
    while i < firstList.count && j < secondList.count {
        let start1 = firstList[i][0], end1 = firstList[i][1]
        let start2 = secondList[j][0], end2 = secondList[j][1]
        // get the intersection interval
        let start = max(start1,start2)
        let end = min(end1,end2)
        
        if start <= end {
            res.append([start, end])
        }
        
        if end1 < end2 {
            i += 1
        } else {
            j += 1
        }
    }
    return res
}
