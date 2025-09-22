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

//21. Merge Two Sorted Lists    Time O(n)
//https://leetcode.com/problems/merge-two-sorted-lists/description/
func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    var head: ListNode? = ListNode(), tail = head, list1 = list1, list2 = list2
    while list1 != nil && list2 != nil {
        if list1!.val < list2!.val {
            tail?.next = list1
            list1 = list1?.next
        } else {
            tail?.next = list2
            list2 = list2?.next
        }
        tail = tail?.next
    }
    tail?.next = list1 ?? list2
    return head?.next
}

//141. Linked List Cycle      Time O(n)
//Floyd's The Tortoise and the Hare Algorithm
//https://leetcode.com/problems/linked-list-cycle/description/
func hasCycle(_ head: ListNode?) -> Bool {
    var fast: ListNode? = head, slow: ListNode? = head
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        if slow === fast { return true }
    }
    return false
}
