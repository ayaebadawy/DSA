import Foundation

/*
backtracting is walking a maze:
At each junction, you choose a valid direction and go forward.
Once you reach the end (a base case), you walk back to the last junction and try the next unexplored path.
You don’t go back and re-walk the same path you already finished.
*/

//22. Generate Parentheses Time(2^n) beacuse of how the tree in built Space O(n) the call stack
//Stack + backtracking problem
//https://leetcode.com/problems/generate-parentheses/description/
func generateParenthesis(_ n: Int) -> [String] {
    var res = [String]()
    return backtrack(0,0,n,"")
    func backtrack(_ openN: Int,_ closedN:Int, _ n: Int, _ str: String) -> [String] {
        if openN == n && closedN == n {
            res.append(str)
        }
        if openN < n {
            backtrack(openN+1,closedN,n,str+"(")
        }
        if closedN < openN {
            backtrack(openN,closedN+1,n,str+")")
        }
        return res
    }
}
generateParenthesis(2)

/*
 backtrack(0, 0, 2, "")
 ├── backtrack(1, 0, 2, "(")
 │   ├── backtrack(2, 0, 2, "((")
 │   │   └── backtrack(2, 1, 2, "(()")
 │   │       └── backtrack(2, 2, 2, "(())")  ✅ base case → append "(())"
 │   └── backtrack(1, 1, 2, "()")
 │       └── backtrack(2, 1, 2, "()(")
 │           └── backtrack(2, 2, 2, "()()") ✅ base case → append "()()"
 */
