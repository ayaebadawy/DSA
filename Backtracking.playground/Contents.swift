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

//78. Subsets Time O(n*2^n) 2^n because of the tree call and extra n becase the subset it self to build it and store it takes n
//https://leetcode.com/problems/subsets/description/
func subsets(_ nums: [Int]) -> [[Int]] {
    var subsets = [[Int]]()
    backtracking(0, [])
    return subsets
    func backtracking(_ i: Int, _ current: [Int]) {
        if i >= nums.count { //basecase we reached bound
            subsets.append(current)
            return
        }
        //include the num
        backtracking(i+1, current + [nums[i]])
        //not include the num
        backtracking(i+1, current)
    }
}

func subsetsWithReturnFromBacktrack(_ nums: [Int]) -> [[Int]] {
    func backtrack(_ i: Int, _ current: [Int]) -> [[Int]] {
        if i >= nums.count {
            return [current]  // ✅ base case returns a wrapped result
        }
        let include = backtrack(i + 1, current + [nums[i]])
        let exclude = backtrack(i + 1, current)
        return include + exclude  // ✅ merge results and return
    }
    return backtrack(0, [])
}

//90. Subsets II Time O(n*2^n) 2^n because of the tree call and extra n becase the subset it self to build it and store it takes n
//https://leetcode.com/problems/subsets-ii/description/
func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
    let nums = nums.sorted()
    var res = [[Int]]()
    backtrack(0,[])
    return res
    func backtrack(_ i: Int, _ curset: [Int]) {
        var i = i
        if i >= nums.count {
            res.append(curset)
            return
        }
        //include the num
        backtrack(i+1, curset + [nums[i]])
        //exclude the num with all it's occurences
        while i + 1 < nums.count && nums[i] == nums[i+1] {
            i += 1
        }
        backtrack(i+1, curset)
    }
}

//77. Combinations Time O(k*2^n) 2^n is the call stack for the tree or the tree size and k for building the set it self
// https://leetcode.com/problems/combinations/description/
func combine(_ n: Int, _ k: Int) -> [[Int]] {
    var res = [[Int]]()
    backtrack(1,[])
    return res
    func backtrack(_ i:Int, _ comp: [Int]) {
        if comp.count == k {
            res.append(comp)
            return
        }
        if i > n { return }
        //include num
        backtrack(i+1, comp + [i])
        //not include the num
        backtrack(i+1, comp)
    }
}
// slightly optimized solution with Time (k* C(n,k)) aka choose n size k, we do not need to not include any number we need to choose between k num so we choose to get the range of this number and the rest untill n if we include 1 then at 2 we do not want to include one again but we want a range from 2 to n and so on
func combineOp(_ n: Int, _ k: Int) -> [[Int]] {
    var res = [[Int]]()
    backtrack(1,[])
    return res
    func backtrack(_ i:Int, _ comp: [Int]) {
        if comp.count == k {
            res.append(comp)
            return
        }
        if i > n { return }
        //include range
        for j in i...n {
            backtrack(j+1, comp + [j])
        }
    }
}

//39. Combination Sum
//https://leetcode.com/problems/combination-sum/description/
func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var res = [[Int]]()
    backtrack(0,[],0)
    return res
    func backtrack(_ i: Int, _ comp: [Int], _ total: Int) {
        if total == target {
            res.append(comp)
            return
        }
        if i >= candidates.count || total > target { return }
        //include num
        backtrack(i, comp + [candidates[i]], total + candidates[i])
        //exclude num
        backtrack(i+1, comp, total)
    }
}
