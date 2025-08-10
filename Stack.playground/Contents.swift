import Foundation

//20. Valid Parentheses
//https://leetcode.com/problems/valid-parentheses/
func isValid(_ s: String) -> Bool {
    var stack = [Character]()
    for char in s {
        if isOpen(char) {
            stack.append(char)
        } else {
            if stack.isEmpty { return false } //close with no open
            else {
                let openP = stack.removeLast()
                if !isMatch(openP, char) { return false}
            }
        }
    }
    return stack.isEmpty //stack should be empty in the end
}

func isOpen(_ char: Character) -> Bool {
    if char == "(" || char == "[" || char == "{" { return true }
    else { return false }
}

func isMatch(_ openP: Character, _ closeP: Character) -> Bool {
    if openP == "(" && closeP == ")" ||
        openP == "[" && closeP == "]" ||
        openP == "{" && closeP == "}" {
        return true
    } else {
        return false
    }
}

isValid("[")

//155. Min Stack
//https://leetcode.com/problems/min-stack/description/
class MinStack {
    
    var stack: [Int]
    var minStack: [Int]
    
    init() {
        stack = []
        minStack = []
    }
    
    func push(_ val: Int) {
        stack.append(val)
        if minStack.isEmpty { minStack.append(val) }
        else { minStack.append(min(minStack.last!, val)) }
    }
    
    func pop() {
        stack.removeLast()
        minStack.removeLast()
    }
    
    func top() -> Int {
        guard let last = stack.last else { return -1 }
        return last
    }
    
    func getMin() -> Int {
        guard let last = minStack.last else { return -1 }
        return last
    }
}

//150. Evaluate Reverse Polish Notation
//https://leetcode.com/problems/evaluate-reverse-polish-notation/
func evalRPN(_ tokens: [String]) -> Int {
    var res = [Int]()
    for t in tokens {
        if let num = Int(t) { res.append(num) }
        else {
            var op2 = res.removeLast()
            var op1 = res.removeLast()
            res.append(preform(op1, op2, t))
        }
    }
    return res[0]
}

func preform(_ op1: Int,_ op2: Int, _ operation: String) -> Int {
    if operation == "+" { return op1 + op2 }
    else if operation == "-" { return op1 - op2 }
    else if operation == "*" { return op1 * op2 }
    else { return op1 / op2 }
}

evalRPN(["4","13","5","/","+"])

