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
