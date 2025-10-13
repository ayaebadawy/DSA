import Foundation

//70. Climbing Stairs    fibinacci series
//https://leetcode.com/problems/climbing-stairs/description/
func climbStairs(_ n: Int) -> Int {
    if n <= 2 { return n }
    var first = 1, sec = 2
    for _ in 3...n {
        let third = first + sec
        first = sec
        sec = third
    }
    return sec
}

//48. Rotate Image   Time O(n2) as we process all elements in the matrix nxn
//https://leetcode.com/problems/rotate-image/
func rotate(_ matrix: inout [[Int]]) {
    var l = 0, r = matrix.count - 1
    while l < r {
        for i in 0..<r-l {
            //current window of elements is r - l + 1 but we do not need to process the last corner already processed hints r - l
            var top = l, bottom = r
            let topLeft = matrix[top][l + i]
            matrix[top][l + i] = matrix[bottom - i][l]
            matrix[bottom - i][l] = matrix[bottom][r - i]
            matrix[bottom][r - i] = matrix[top + i][r]
            matrix[top + i][r] = topLeft
        }
        l += 1
        r -= 1
    }
}

//54. Spiral Matrix
//https://leetcode.com/problems/spiral-matrix/description/
func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    var res = [Int]()
    var l = 0, r = matrix[0].count - 1
    var top = 0, bottom = matrix.count - 1
    while l <= r && top <= bottom {
        for i in l...r {
            res.append(matrix[top][i])
        }
        top += 1
        if top > bottom { break }
        for i in top...bottom { // crash at creation if range is invalid
            res.append(matrix[i][r])
        }
        r -= 1
        if l > r { break }
        for i in stride(from: r, through: l, by: -1) { // skips execution entirely if the range is invalid
            res.append(matrix[bottom][i])
        }
        bottom -= 1
        if top > bottom { break }
        for i in stride(from: bottom, through: top, by: -1) {
            res.append(matrix[i][l])
        }
        l += 1
    }
    return res
}

//2013. Detect Squares     Time O(n)
//https://leetcode.com/problems/detect-squares/description/
class DetectSquares {
    struct Point: Hashable {
        let x: Int
        let y: Int
    }
    var pts: [Point] // x,y
    var ptsCount: [Point: Int] // (x,y) : count
    
    init() {
        pts = []
        ptsCount = [:]
    }
    
    func add(_ point: [Int]) {
        let pt = Point(x: point[0], y: point[1])
        pts.append(pt)
        ptsCount[pt, default: 0] += 1
    }
    
    func count(_ point: [Int]) -> Int {
        var res = 0
        let px = point[0], py = point[1]
        for pt in pts {
            let x = pt.x, y = pt.y
            if abs(x-px) == abs(y-py) && px != x && py != y { // check if there's a diagonal?
                //diagonal is when x-x == y-y (0,0) (3,3)
                let pt1 = Point(x: x, y: py) //get the top point
                let pt2 = Point(x: px, y: y) //get the bottom point
                if let p1Count = ptsCount[pt1],
                   let p2Count = ptsCount[pt2] {
                    res += p1Count * p2Count // if we have multiple copys, we consider them diff squars, and get their count and multiply
                }
            }
        }
        return res
    }
}
