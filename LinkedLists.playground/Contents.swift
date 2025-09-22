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

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

//206. Reverse Linked List     Time O(n)
//https://leetcode.com/problems/reverse-linked-list/description/
func reverseList(_ head: ListNode?) -> ListNode? {
    var prev: ListNode? = nil, curr = head
    while curr != nil {
        let nxt = curr?.next // temp var to save the next node before breaking the link
        curr?.next = prev
        prev = curr
        curr = nxt
    }
    return prev
}
