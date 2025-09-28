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
// fast and slow pointers must meet the fast pointer will catch up to the slow pointer as this moves by one and this moves by tow so each iteration the fast pointer closes the distance by 1
//https://leetcode.com/problems/linked-list-cycle/description/
func hasCycle(_ head: ListNode?) -> Bool {
    var fast = head, slow = head
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        if slow === fast { return true }
    }
    return false
}

//876. Middle of the Linked List      Time O(n)
//https://leetcode.com/problems/middle-of-the-linked-list/description/
func middleNode(_ head: ListNode?) -> ListNode? {
    var fast = head, slow = head
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    return slow
}

//142. Linked List Cycle II        Time O(n)
// the 2 slow pointers are garenteed to meet at the head of the cycle, after finding the cycle, proved mathimatically, the distance from the slow pointer inside the cycle to the head of the cycle and the distance from the head to the list to the head of the cycle are equal
// p = x
//2p(c-x) = p+c+c-x
//p-x = 0 aka p = x
//https://leetcode.com/problems/linked-list-cycle-ii/
func detectCycle(_ head: ListNode?) -> ListNode? {
    var fast = head, slow = head
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        if fast === slow { break }
    }
    if fast == nil || fast?.next == nil { return nil }
    var slow2 = head
    while slow !== slow2 {
        slow = slow?.next
        slow2 = slow2?.next
    }
    return slow
}

//2130. Maximum Twin Sum of a Linked List     Time O(n)
//https://leetcode.com/problems/maximum-twin-sum-of-a-linked-list/description/
//we use fast and slow pointer to deremine the midway point of the linked list,
//while doing so, we reverse the first half of the linked list,
//we do so by keeping track of a prev pointer, we need to shift slow to slow.next but we also need to break slow.next and set it to pre which is the reverse op, so we save slow.next to a temp var then we can safly break that and set it to prev, then we need to update the pointer prev is moving to slow and slow is moving to slow. next
//after that we just loop over and sum the vals and get the max.
func pairSum(_ head: ListNode?) -> Int {
    var pre: ListNode? = nil, fast = head, slow = head, res = 0
    while fast != nil && fast?.next != nil {
        fast = fast?.next?.next
        var temp = slow?.next
        slow?.next = pre
        pre = slow
        slow = temp
    }
    
    while slow != nil && pre != nil {
        res = max(res, slow!.val + pre!.val)
        slow = slow?.next
        pre = pre?.next
    }
    return res
}

//287. Find the Duplicate Number
//https://leetcode.com/problems/find-the-duplicate-number/description/

func findDuplicate(_ nums: [Int]) -> Int {
    var fast = 0, slow = 0
    while true {
        slow = nums[slow]
        fast = nums[nums[fast]]
        if fast == slow { break }
    }
    var slow2 = 0
    while true {
        slow = nums[slow]
        slow2 = nums[slow2]
        if slow == slow2 { return slow}
    }
}

//Double linked list for moving forward and backwords
//1472. Design Browser History      Time O(n) moving forword and back, Time O(1) visiting new page
//https://leetcode.com/problems/design-browser-history/description/
class DListNode {
    
    var val: String
    var pre: DListNode?
    var next: DListNode?
    
    init(_ val: String, _ pre: DListNode? = nil, _ next: DListNode? = nil) {
        self.val = val
        self.pre = pre
        self.next = next
    }
}

class BrowserHistory {
    
    var cur: DListNode?
    
    init(_ homepage: String) {
        cur = DListNode(homepage)
    }
    
    func visit(_ url: String) {
        let node = DListNode(url, cur)
        cur?.next = node
        cur = cur?.next
    }
    
    func back(_ steps: Int) -> String {
        var steps = steps
        while cur?.pre != nil && steps > 0 {
            cur = cur?.pre
            steps -= 1
        }
        return cur!.val
    }
    
    func forward(_ steps: Int) -> String {
        var steps = steps
        while cur?.next != nil && steps > 0 {
            cur = cur?.next
            steps -= 1
        }
        return cur!.val
    }
}

//707. Design Linked List      Time O(1) -> init, addAtHead, addAtTail, Time O(n) -> get, addAtIndex, deleteAtIndex
//https://leetcode.com/problems/design-linked-list/description/
class IListNode {
    
    var val: Int
    var prev: IListNode?
    var next: IListNode?
    
    init(_ val: Int, _ prev: IListNode? = nil, _ next: IListNode? = nil ) {
        self.val = val
        self.prev = prev
        self.next = next
    }
}

class MyLinkedList {
    
    var left = IListNode(0), right = IListNode(0)
    
    init() {
        left.next = right
        right.prev = left
    }
    
    func get(_ index: Int) -> Int {
        var index = index, cur = left.next
        while cur != nil && index > 0 {
            cur = cur?.next
            index -= 1
        }
        if cur != nil && cur !== right && index == 0 { return cur!.val }
        else { return -1 }
    }
    
    func addAtHead(_ val: Int) {
        var node = IListNode(val), cur = left.next
        left.next = node
        cur?.prev = node
        node.prev = left
        node.next = cur
    }
    
    func addAtTail(_ val: Int) {
        var node = IListNode(val), cur = right.prev
        right.prev = node
        cur?.next = node
        node.next = right
        node.prev = cur
    }
    
    func addAtIndex(_ index: Int, _ val: Int) {
        var cur = left.next, index = index
        while cur != nil && index > 0 {
            index -= 1
            cur = cur?.next
        }
        if cur != nil && index == 0 {
            var node = IListNode(val), prev = cur?.prev, next = cur
            prev?.next = node
            next?.prev = node
            node.next = next
            node.prev = prev
        }
    }
    
    func deleteAtIndex(_ index: Int) {
        var index = index, cur = left.next
        while cur != nil && index > 0 {
            index -= 1
            cur = cur?.next
        }
        if cur != nil && cur !== right && index == 0 {
            var next = cur?.next, prev = cur?.prev
            next?.prev = prev
            prev?.next = next
        }
    }
}

//19. Remove Nth Node From End of List
//https://leetcode.com/problems/remove-nth-node-from-end-of-list/description/
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    var dummy: ListNode? = ListNode(0, head)
    var left = dummy, right = head, shift = n // left and right pointers
    while shift > 0 && right != nil { // keep shifting the right pointer untill n = 0, which means the distance between left and right is exactly = n
        right = right?.next
        shift -= 1
    }
    // keep shifting both pointers untill right is at the end, which means that left is at the node before the one we need to delete gived that we maintained the distance between them as n
    
    while right != nil {
        right = right?.next
        left = left?.next
    }
    left?.next = left?.next?.next
    return dummy?.next
}

//143. Reorder List
//https://leetcode.com/problems/reorder-list/description/
func reorderList(_ head: ListNode?) {
    var slow = head, fast = head?.next
    // get the half way point of the list
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    var second = slow?.next, pre: ListNode? = nil
    slow?.next = pre // break the link between 2 lists VIP
    //reverse the list
    while second != nil {
        let temp = second?.next
        second?.next = pre
        pre = second
        second = temp
    }
    var first = head
    second = pre
    //merge 2 lists
    while second != nil {
        let temp1 = first?.next, temp2 = second?.next
        first?.next = second
        second?.next = temp1
        first = temp1
        second = temp2
    }
}

//2. Add Two Numbers
//https://leetcode.com/problems/add-two-numbers/description/
func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var l1 = l1, l2 = l2, dummy: ListNode? = ListNode(0), cur = dummy
    var carry = 0
    
    while l1 != nil || l2 != nil || carry > 0 {
        let val = (l1?.val ?? 0) + (l2?.val ?? 0) + carry
        let digit = val % 10
        carry = val / 10
        cur?.next = ListNode(digit)
        l1 = l1?.next
        l2 = l2?.next
        cur = cur?.next
    }
    return dummy?.next
}
