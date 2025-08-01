import Foundation

public class Node: Equatable {
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs === rhs
    }
    public var val: Int
    public var next: Node?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
// 708. Insert into a Sorted Circular Linked List
// https://leetcode.com/problems/insert-into-a-sorted-circular-linked-list/description/?envType=company&envId=facebook&favoriteSlug=facebook-thirty-days

func insert(_ head: Node?, _ insertVal: Int) -> Node? {
    let newNode = Node(insertVal)
    
    // Case 1: Empty list
    guard let head = head else {
        newNode.next = newNode
        return newNode
    }
    
    var cur = head
    while cur.next != head {
        let next = cur.next!
        // Case 2: Normal case: insert between two values
        if insertVal >= cur.val && insertVal <= next.val {
            break
        }
        // Case 3: At rotation point (max -> min)
        if cur.val > next.val {
            if insertVal >= cur.val || insertVal <= next.val {
                break
            }
        }
        cur = next
    }
    
    newNode.next = cur.next
    cur.next = newNode
    return head
}
