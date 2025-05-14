import Foundation

let nums: [Int] = [1,3,2,5,7,6,9,12,5,19,8]

func getMax(_ nums: [Int]) -> Int {
    var max = 0
    for n in nums {
        max = n > max ? n : max
    }
    return max
}
getMax(nums)

func getMin(_ nums: [Int]) -> Int {
    var min = Int.max
    for n in nums {
        min = n < min ? n : min
    }
    return min
}
getMin(nums)

let numsWithNegatives: [Int] = [1,-3,2,5,7,6,-9,12,5,-19,8]

func getMaxFromArrayWithNegative(_ nums: [Int]) -> Int {
    var max = Int.min
    for n in nums {
        max = n > max ? n : max
    }
    return max
}

getMaxFromArrayWithNegative(numsWithNegatives)
