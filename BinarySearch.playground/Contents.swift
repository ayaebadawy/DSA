import Foundation

// 167. Two Sum II - Input Array Is Sorted  Time O(logN)
// https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/description/
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    var l = 0, r = numbers.count - 1
    while l < r {
        if numbers[l] + numbers[r] == target { return [l+1, r+1] }
        else if numbers[l] + numbers[r] > target {
            r -= 1
        } else {
            l += 1
        }
    }
    return []
}

// 704. Binary Search
// https://leetcode.com/problems/binary-search/description/
func search(_ nums: [Int], _ target: Int) -> Int {
    var l = 0, r = nums.count - 1
    while l <= r {
        let  mid = l + ((r-l) / 2)
        if nums[mid] > target { r = mid - 1 }
        else if nums[mid] < target { l = mid + 1 }
        else { return mid }
    }
    return -1
}

// 74. Search a 2D Matrix    Staircase Search   Time O(m+n)
// Another solution would be to flatten the 2D matrix and then run binary search
// https://leetcode.com/problems/search-a-2d-matrix/description/
func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    var col = 0, row = matrix.count - 1
    var inBounds: Bool {
        return row >= 0 && row < matrix.count
        && col >= 0 && col < matrix[0].count
    }
    while inBounds {
        if matrix[row][col] > target {
            row -= 1
        } else if matrix[row][col] < target {
            col += 1
        } else {
            return true
        }
    }
    return false
}

// 33. Search in Rotated Sorted Array   Time O(logN)
// https://leetcode.com/problems/search-in-rotated-sorted-array/description/
func searchRotatedSortedArray(_ nums: [Int], _ target: Int) -> Int {
    var l = 0, r = nums.count - 1
    while l <= r {
        let m = (l+r) / 2
        if nums[m] == target { return m }
        if nums[l] <= nums[m] { // left sorted part
            if nums[l] <= target && target < nums[m] { r = m - 1 }
            else { l = m + 1 }
        } else {
            if nums[r] >= target && target > nums[m] { l = m + 1 }
            else { r = m - 1 }
        }
    }
    return -1
}

//153. Find Minimum in Rotated Sorted Array
//https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/description/
func findMin(_ nums: [Int]) -> Int {
    var l = 0, r = nums.count - 1, res = nums[l]
    while l <= r {
        if nums[l] < nums[r] { return min(res, nums[l]) } // it's sorted
        else {
            let m = (l + r) / 2
            res = min(res, nums[m])
            if nums[m] >= nums[l] { l = m + 1 }
            else { r = m - 1 }
        }
    }
    return res
}
