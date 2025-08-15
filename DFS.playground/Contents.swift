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
        if let seen = visit[course] {
            return seen
        }
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

// 79. Word Search
// https://leetcode.com/problems/word-search/description/
func exist(_ board: [[Character]], _ word: String) -> Bool {
    let word = Array(word)
    let rows = board.count, cols = board[0].count
    var visit = Set<String>()
    let dir = [(0,1), (0,-1), (-1,0), (1,0)]
    
    func dfs(_ r: Int, _ c: Int, _ i: Int) -> Bool {
        if i == word.count { return true } //we found the word as i is char index
        else {
            if r >= 0 && r < rows && c >= 0 && c < cols && !visit.contains("\(r)\(c)")
                && board[r][c] == word[i] {
                visit.insert("\(r)\(c)") //make sure that in this iteration we do not visit any position twice while searching for the word
                for (dr,dc) in dir {
                    if dfs(r+dr, c+dc, i+1) { return true}
                }
                visit.remove("\(r)\(c)") //so that we can reuse and visit in other iterations
            }
            return false
        }
    }
    
    for r in 0..<rows {
        for c in 0..<cols {
            if dfs(r,c,0) { return true }
        }
    }
    
    return false
}

// 131. Palindrome Partitioning
// https://leetcode.com/problems/palindrome-partitioning/description/
func partition(_ s: String) -> [[String]] {
    var res = [[String]]()
    var part = [String]()
    let sArray = Array(s)
    
    func dfs(_ j: Int, _ i: Int) {
        if i >= sArray.count {
            if i == j {
                res.append(part)
            }
            return
        }
        
        if isPali(sArray, j, i) {
            part.append(String(sArray[j...i]))
            dfs(i + 1, i + 1)
            part.removeLast()
        }
        
        dfs(j, i + 1)
    }
    
    func isPali(_ s: [Character], _ l: Int, _ r: Int) -> Bool {
        var l = l, r = r
        while l < r {
            if s[l] != s[r] {
                return false
            }
            l += 1
            r -= 1
        }
        return true
    }
    
    dfs(0, 0)
    return res
}
