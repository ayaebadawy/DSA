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
