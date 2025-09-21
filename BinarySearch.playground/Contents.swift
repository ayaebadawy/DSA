import Foundation


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
//74. Search a 2D Matrix    Binary Search   Time log(n*m)
// flatten the arrar in theory not really
// l and r and the start and end
// to get the m at the 2D represenation row = m / cols and col = m % col
// which is a math equation to represent 1D into 2D
func searchMatrix2(_ matrix: [[Int]], _ target: Int) -> Bool {
    var l = 0, r = matrix.count * matrix[0].count - 1
    while l <= r {
        let m = (l+r) / 2
        let row = m / matrix[0].count
        let col = m % matrix[0].count
        if matrix[row][col] > target { r = m - 1 }
        else if matrix[row][col] < target { l = m + 1 }
        else { return true }
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

//4. Median of Two Sorted Arrays    Time O(log(min(m,n)))
//https://leetcode.com/problems/median-of-two-sorted-arrays/
func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    var arr1 = nums1, arr2 = nums2
    if arr1.count > arr2.count {
        arr1 = nums2
        arr2 = nums1
    }
    
    let total = arr1.count + arr2.count, half = total / 2
    var l = 0,  r = arr1.count
    
    while true {
        let i = (l + r) / 2
        let j = half - i
        
        let arr1Left = i > 0 ? Double(arr1[i - 1]) : -Double.infinity
        let arr1Right = i < arr1.count ? Double(arr1[i]) : Double.infinity
        let arr2Left = j > 0 ? Double(arr2[j - 1]) : -Double.infinity
        let arr2Right = j < arr2.count ? Double(arr2[j]) : Double.infinity
        
        if arr1Left <= arr2Right && arr2Left <= arr1Right {
            if total % 2 == 1 {
                return min(arr1Right, arr2Right)
            } else {
                return (max(arr1Left, arr2Left) + min(arr2Right, arr1Right)) / 2.0
            }
        } else if arr1Left > arr2Right {
            r = i - 1
        } else {
            l = i + 1
        }
    }
}

/*
 arr1: [1 | 3]
 arr2: [2, 4 | 5, 6]
 
 arr1Left = 1
 arr1Right = 3
 arr2Left = 4
 arr2Right = 5
 
 Check partition validity:
 arr1Left <= arr2Right: 1 <= 5 ✅
 arr2Left <= arr1Right: 4 <= 3 ❌
 
 Second binary search iteration
 i = (2 + 2) / 2 = 2
 j = 3 - 2 = 1
 
 arr1: [1, 3 | ]
 arr2: [2 | 4, 5, 6]
 
 arr1Left = 3
 arr1Right = ∞ (out of bounds)
 arr2Left = 2
 arr2Right = 4
 Check partition validity:
 arr1Left <= arr2Right: 3 <= 4 ✅
 arr2Left <= arr1Right: 2 <= ∞ ✅
 
 ✅ Valid partition found.
 */

//981. Time Based Key-Value Store     Time O(logn)
//https://leetcode.com/problems/time-based-key-value-store/description/
class TimeMap {
    
    var dict: [String: [(String, Int)] ]
    
    init() {
        dict = [:]
    }
    
    func set(_ key: String, _ value: String, _ timestamp: Int) {
        dict[key, default: []].append((value, timestamp))
    }
    
    func get(_ key: String, _ timestamp: Int) -> String {
        var res = ""
        guard let values = dict[key] else { return "" }
        var l = 0, r = values.count - 1
        while l <= r {
            let m = (l+r) / 2
            if values[m].1 <= timestamp {
                res = values[m].0 // we update the res since we found a valid value, checking if the == will not work here as we may not find an exact match and we need to update the res to the lesser timestamp we found and then update the pointers
                l = m + 1
            } else {
                r = m - 1
            }
        }
        return res
    }
}

//875. Koko Eating Bananas
//https://leetcode.com/problems/koko-eating-bananas/
func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
    var l = 1, r = piles.max()!, minK = r
    while l <= r {
        let eatingSpeed = (l+r) / 2
        let timeTakenToEatAllPiles = piles
            .map{ Int( ceil( Double($0) / Double(eatingSpeed) )) }.reduce(0,+)
        //time taken can also be calculated with reduce directly
        // piles.reduce(0) { $0 + Int(ceil( Double($1) / Double(eatingSpeed) ) ) }
        if timeTakenToEatAllPiles <= h {
            minK = min(minK, eatingSpeed)
            r = eatingSpeed - 1
        } else {
            l = eatingSpeed + 1
        }
    }
    return minK
}
