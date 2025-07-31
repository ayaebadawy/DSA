import Foundation

//13. Roman to Integer
//https://leetcode.com/problems/roman-to-integer/description/?envType=company&envId=facebook&favoriteSlug=facebook-thirty-days
//Go through the input string and if a smaller number appears before a larger one we subtract it, else we add it to the res

func romanToInt(_ s: String) -> Int { //Time O(n), Space O(n)
    var romanDict: [Character: Int] = [
        "I": 1,
        "V": 5,
        "X": 10,
        "L": 50,
        "C": 100,
        "D": 500,
        "M": 1000
    ]
    let s = Array(s)
    var res = 0
    for i in 0..<s.count {
        if i + 1 < s.count && romanDict[s[i]] ?? 0 < romanDict[s[i+1]] ?? 0 {
            res -= romanDict[s[i]] ?? 0
        } else {
            res += romanDict[s[i]] ?? 0
        }
    }
    return res
}
romanToInt("III")
romanToInt("LVIII")
romanToInt("MCMXCIV")
