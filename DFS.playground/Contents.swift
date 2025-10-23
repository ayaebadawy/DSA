import Foundation

// Leetcode 207. Course Schedule
// https://leetcode.com/problems/course-schedule/description/

//Time Complexity O(n+p) n = num of courses, p = num of prereq,
//Space Complexity O(n) the adjList of the courses
func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    var adjList = [Int: [Int]]() // course: [prereq]
    var visit = [Int: Bool]() //course: true for visited and processed, false currently being visited
    for prereq in prerequisites { //[1,0]
        adjList[prereq[1], default: []].append(prereq[0])
    }
    
    for course in 0..<numCourses {
        if !dfs(course) { return false}
    }
    
    //post order dfs treversal: we process the childeren first and then process the parent
    func dfs(_ course: Int) -> Bool {
        if let seen = visit[course] { return seen }
        visit[course] = false
        for prereq in adjList[course, default: []] {
            if !dfs(prereq) { return false }
        }
        visit[course] = true
        return true
    }
    
    return true
}

canFinish(2, [[1,0]]) //true
canFinish(2, [[1,0],[0,1]]) //false

//129. Sum Root to Leaf Numbers
// https://leetcode.com/problems/sum-root-to-leaf-numbers/?envType=company&envId=facebook&favoriteSlug=facebook-thirty-days
public class TreeNodeSumNumbers {
    public var val: Int
    public var left: TreeNodeSumNumbers?
    public var right: TreeNodeSumNumbers?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNodeSumNumbers?, _ right: TreeNodeSumNumbers?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

func sumNumbers(_ root: TreeNodeSumNumbers?) -> Int {
    return dfs(root, 0)
    func dfs(_ node: TreeNodeSumNumbers?,_ num: Int) -> Int {
        guard let node = node else { return 0 }
        let num = num * 10 + node.val // process the parent first. i.e preorder
        if node.left == nil && node.right == nil {
            return num
        } else {
            return dfs(node.left, num) + dfs(node.right, num)
        }
    }
}

//https://leetcode.com/problems/pacific-atlantic-water-flow/
//417. Pacific Atlantic Water Flow    Time O(n*m)
func pacificAtlantic(_ heights: [[Int]]) -> [[Int]] {
    var rows = heights.count, cols = heights[0].count
    var pac = Set<[Int]>() , atl = Set<[Int]>()
    let dir = [(0,1),(0,-1),(1,0),(-1,0)]
    
    for c in 0..<cols {
        dfs(0, c, &pac, heights[0][c])
        dfs(rows - 1, c, &atl, heights[rows-1][c])
    }
    for r in 0..<rows {
        dfs(r, 0, &pac, heights[r][0])
        dfs(r, cols - 1, &atl, heights[r][cols-1])
    }
    func dfs(_ r: Int, _ c: Int ,_ visit: inout Set<[Int]> ,_ preHeight: Int) {
        if r >= rows || r < 0 || c >= cols || c < 0
            || visit.contains([r,c]) || heights[r][c] < preHeight { return }
        visit.insert([r,c])
        for (dr, dc) in dir {
            dfs(r+dr, c+dc, &visit, heights[r][c])
        }
    }
    
    return Array(pac.intersection(atl))
}

//200. Number of Islands       Time O(n*m)
//https://leetcode.com/problems/number-of-islands/description/
func numIslands(_ grid: [[Character]]) -> Int {
    var rows = grid.count, cols = grid[0].count
    var visit = Set<String>(), islands = 0
    for r in 0..<rows {
        for c in 0..<cols {
            if grid[r][c] == "1" && !visit.contains("\(r) \(c)") {
                dfs(r,c)
                islands += 1
            }
        }
    }
    func dfs(_ r: Int, _ c: Int) {
        if r < rows && r >= 0 && c < cols && c >= 0 &&
            !visit.contains("\(r) \(c)") && grid[r][c] == "1" {
            visit.insert("\(r) \(c)")
            dfs(r+1, c)
            dfs(r-1, c)
            dfs(r, c+1)
            dfs(r, c-1)
        }
    }
    return islands
}

//695. Max Area of Island      Time O(n*m)
//https://leetcode.com/problems/max-area-of-island/description/
func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
    var rows = grid.count, cols = grid[0].count
    var visit = Set<String>(), maxArea = 0
    for r in 0..<rows {
        for c in 0..<cols {
            if grid[r][c] == 1 {
                maxArea = max(maxArea, dfs(r,c))
            }
        }
    }
    func dfs(_ r: Int, _ c: Int) -> Int {
        var dir = [(0,1),(0,-1),(1,0),(-1,0)]
        if r < rows && r >= 0 && c < cols && c >= 0 && grid[r][c] == 1 &&
            !visit.contains("\(r) \(c)") {
            visit.insert("\(r) \(c)")
            return 1 + dfs(r+1,c) + dfs(r-1,c) + dfs(r,c-1) + dfs(r,c+1)
        } else {
            return 0
        }
    }
    return maxArea
}

//130. Surrounded Regions    Time O(n*m)
//https://leetcode.com/problems/surrounded-regions/
func solve(_ board: inout [[Character]]) {
    var rows = board.count, cols = board[0].count
    //capture unsurronded regions on boarder
    for r in 0..<rows {
        dfs(r, 0)
        dfs(r, cols-1)
    }
    for c in 0..<cols {
        dfs(0, c)
        dfs(rows-1, c)
    }
    //capture surronded regions inside
    for r in 0..<rows {
        for c in 0..<cols {
            if board[r][c] == "O" { board[r][c] = "X" }
        }
    }
    //uncapture unsurronded regions, which we tured into a temp var
    for r in 0..<rows {
        for c in 0..<cols {
            if board[r][c] == "T" { board[r][c] = "O" }
        }
    }
    
    func dfs(_ r: Int, _ c: Int) {
        if r < rows && r >= 0
            && c < cols && c >= 0 && board[r][c] == "O" {
            board[r][c] = "T"
            dfs(r+1, c)
            dfs(r-1, c)
            dfs(r, c+1)
            dfs(r, c-1)
        }
    }
}
