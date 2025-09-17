import Foundation

//125. Valid Palindrome
//https://leetcode.com/problems/valid-palindrome/description/
func isPalindrome(_ s: String) -> Bool {
    let s = Array(s.lowercased()).filter { $0.isLetter || $0.isNumber }
    var l = 0, r = s.count - 1
    while l <= r {
        if s[l] != s[r] { return false }
        l += 1
        r -= 1
    }
    return true
}

//11. Container With Most Water
//https://leetcode.com/problems/container-with-most-water/
func maxArea(_ height: [Int]) -> Int {
    var res = 0, l = 0, r = height.count - 1
    while l < r {
        let area = (r - l) * min(height[l], height[r])
        res = max(res, area)
        if height[l] < height[r] { l += 1 }
        else { r -= 1 }
    }
    return res
}

//https://leetcode.com/problems/trapping-rain-water/
//42. Trapping Rain Water
func trap(_ height: [Int]) -> Int {
    if height.isEmpty { return 0 }
    var l = 0, r = height.count - 1, res = 0
    var maxL = height[l], maxR = height[r]
    while l < r {
        // we don't need the right bounders as we need the min value between both and since we intered this condition it means that out l boundry was the smaller one
        if height[l] < height[r] {
            l += 1
            maxL = max(maxL, height[l])
            // this will never be neg as we made sure that maxL is the heightest val between the tow earlier
            res += maxL - height[l]
        } else {
            r -= 1
            maxR = max(maxR, height[r])
            res += maxR - height[r]
        }
    }
    return res
}

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

//167. Two Sum II - Input Array Is Sorted
// https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/description/
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    var l = 0, r = numbers.count - 1
    while l < r {
        //since it's sorted increment by shifting l
        if numbers[l] + numbers[r] < target { l += 1}
        //it's sorted so we need to decrement
        else if numbers[l] + numbers[r] > target { r -= 1}
        else { return [l+1,r+1] }
    }
    return []
}

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

//26. Remove Duplicates from Sorted Array
//https://leetcode.com/problems/remove-duplicates-from-sorted-array/description/
func removeDuplicates(_ nums: inout [Int]) -> Int {
    var l = 1 // l pointer represents the number that will be replaced
    for r in 1..<nums.count{
        //we keep going untill we find and emelent that doesn't match it's previous one which means it's not a dublicate and since l in pointing at the position where we need to place our next unique element we shift them and increment l
        if nums[r] != nums[r-1] {
            nums[l] = nums[r]
            l += 1
        }
    }
    return l
}

//367. Valid Perfect Square
//https://leetcode.com/problems/valid-perfect-square/description/
func isPerfectSquare(_ num: Int) -> Bool {
    var l = 1, r = num
    while l <= r {
        let m = (l+r) / 2, m2 = m * m
        if m2 == num { return true }
        else if m2 > num { r = m - 1 }
        else { l = m + 1 }
    }
    return false
}
