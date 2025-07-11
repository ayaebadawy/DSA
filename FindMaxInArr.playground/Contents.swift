import Foundation

let nums: [Int] = [1,3,2,5,7,6,9,12,5,19,8]

func getMax(_ nums: [Int]) -> Int {
    var max = 0
    for n in nums {
        max = n > max ? n : max
    }
    return max
}
getMax(nums)

func getMin(_ nums: [Int]) -> Int {
    var min = Int.max
    for n in nums {
        min = n < min ? n : min
    }
    return min
}
getMin(nums)

let numsWithNegatives: [Int] = [1,-3,2,5,7,6,-9,12,5,-19,8]

func getMaxFromArrayWithNegative(_ nums: [Int]) -> Int {
    var max = Int.min
    for n in nums {
        max = n > max ? n : max
    }
    return max
}

getMaxFromArrayWithNegative(numsWithNegatives)

/*
 Location    First Octet Range    Description
 Location 1    0 to 127    Class A range (example: private/public)
 Location 2    128 to 191    Class B range
 Location 3    192 to 223    Class C range
 Location 4    224 to 239    Class D (multicast addresses)
 Location 5    240 to 255    Class E (experimental)
 */

func locationDetection(_ ip_address: [String]) -> [Int] {
    var results: [Int] = []
    
    main: for (i, address) in ip_address.enumerated() {
        let octets = address.split(separator: ".")
        if octets.count != 4 {
            results.append(-1)
            continue
        }
        else {
            for octet in octets {
                if Int(octet)! > 255 {
                    results.append(-1)
                    continue main
                }
            }
        }
        let firstOctet = Int(octets[0])!
        switch firstOctet {
        case 0...127: results.append(1)
        case 128...191: results.append(2)
        case 192...223: results.append(3)
        case 224...239: results.append(4)
        case 240...255: results.append(5)
        default: results.append(-1) // Should never hit this
        }
    }
    
    return results
}

locationDetection([
    "225.45.67.89",
    "192.255.255.1",
    "10.10.10.232",
    "0.0.550.226",
    "255.255.255.255",
    "123.234.240.10",
    "225.225.225.400",
])

func calculate(_ s: String) -> Int {
        var n = 0
        var stack = [Int]()
        var op = "+"
        for char in s+"+" where char != " " {
            if let number = char.wholeNumberValue {
                n = n * 10 + number
            } else {
                // we encounter an op
                switch op {
                    case "+":
                    stack.append(n)
                    case "-":
                    stack.append(-n)
                    case "*":
                    stack.append(stack.removeLast() * n)
                    case "/":
                    stack.append(stack.removeLast() / n)
                    default: break
                }
                n = 0
                op = String(char)
            }
        }
        return stack.reduce(0, +)
    }
