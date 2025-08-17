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

//17. Letter Combinations of a Phone Number
//https://leetcode.com/problems/letter-combinations-of-a-phone-number/
func letterCombinations(_ digits: String) -> [String] {
    guard !digits.isEmpty else { return [] }
    let digitArr = Array(digits)
    var dict: [Character: String] = [
        "2": "abc", "3": "def", "4": "ghi", "5": "jkl",
        "6": "mno", "7": "pqrs", "8": "tuv","9": "wxyz"
    ]
    var res = [String]()
    backtrack(0,"")
    return res
    func backtrack(_ i: Int, _ str: String) {
        if str.count == digits.count {
            res.append(str)
            return
        }
        if i >= digitArr.count { return }
        for c in dict[digitArr[i]]! {
            backtrack(i+1, str + String(c))
        }
    }
}

//46. Permutations Time O(n*n!) n! as the premutation choose from 4 then 3 then 2 then 1 and that's factorial, and n because fore loop that tries every value that was not yest used.
//https://leetcode.com/problems/permutations/description/
func permute(_ nums: [Int]) -> [[Int]] {
    var res = [[Int]]()
    var used = [Bool](repeating: false, count: nums.count)
    backtrack([])
    return res
    func backtrack(_ perm: [Int]) {
        if perm.count == nums.count {
            res.append(perm)
            return
        }
        
        for i in 0..<nums.count {
            if used[i] { continue }
            used[i] = true
            backtrack(perm + [nums[i]])
            used[i] = false
        }
    }
}

/*
 Start: []
 → Choose 1 → [1]
    → Choose 2 → [1,2]
       → Choose 3 → [1,2,3] ✅
    → Choose 3 → [1,3]
       → Choose 2 → [1,3,2] ✅
 → Choose 2 → [2]
    → Choose 1 → [2,1]
       → Choose 3 → [2,1,3] ✅
 ... etc.
 */

//47. Permutations II Same Time as 46. Permutations
//https://leetcode.com/problems/permutations-ii/description/
func permuteUnique(_ nums: [Int]) -> [[Int]] {
    let nums = nums.sorted()
    var res = [[Int]]()
    var used = [Bool](repeating: false, count: nums.count)
    backtrack([])
    return res
    func backtrack(_ perm: [Int]) {
        if perm.count == nums.count {
            res.append(perm)
            return
        }
        for i in 0..<nums.count {
            if used[i] { continue }
            if i > 0 && nums[i] == nums[i-1] && !used[i-1] { continue }
            used[i] = true
            backtrack(perm + [nums[i]])
            used[i] = false
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
    let arr = Array(s)
    dfs(0,[])
    return res
    
    func dfs(_ i: Int, _ part: [String]) {
        if i >= arr.count {
            res.append(part)
            return
        }
        for j in i..<arr.count { // checks all possible substrings from i ... end and checks if it's a palindrom, if it is we append it and recursivly call dfs on the next sub string starting at j
            if isPali(i,j) {
                dfs(j+1, part + [String(arr[i...j])])
            }
        }
    }
    
    func isPali(_ l: Int, _ r: Int) -> Bool {
        var l = l , r = r
        while l < r {
            if arr[l] != arr[r] { return false }
            else {
                l += 1
                r -= 1
            }
        }
        return true
    }
}

// 51. N-Queens
// https://leetcode.com/problems/n-queens/description/
func solveNQueens(_ n: Int) -> [[String]] {
    var res = [[String]]()
    var board = Array(repeating: Array(repeating: ".", count: n), count: n)
    dfs(0, [], [], [])
    return res
    
    func dfs(_ r: Int,_ posDig: [Int], _ negDig: [Int], _ col: [Int]) {
        if r == n {
            res.append(board.map { $0.joined() })
            return
        }
        for c in 0..<n {
            if !posDig.contains(r+c) && !negDig.contains(r-c) && !col.contains(c) {
                board[r][c] = "Q"
                dfs(r+1, posDig + [r+c], negDig + [r-c], col + [c])
                board[r][c] = "."
            }
        }
    }
}
