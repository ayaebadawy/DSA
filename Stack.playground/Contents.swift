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
