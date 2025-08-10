import Foundation

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
