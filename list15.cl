class ListNode {
    data : Int;
    next : ListNode;
    
    init(d : Int, n : ListNode) : ListNode {
        {
            data <- d;
            next <- n;
            self;
        }
    };
    
    getData() : Int { data };
    
    getNext() : ListNode { next };
    
    setNext(n : ListNode) : ListNode {
        next <- n
    };
};

class LinkedList {
    head : ListNode;
    size : Int;
    
    init() : LinkedList {
        {
            head <- (new ListNode).init(0, (new ListNode));  -- 头节点
            size <- 0;
            self;
        }
    };
    
    -- Insert at front
    insert(data : Int) : LinkedList {
        let new_node : ListNode <- (new ListNode).init(data, head.getNext()) in
        {
            head.setNext(new_node);
            size <- size + 1;
            self;
        }
    };
    
    -- Delete a node with given data
    delete(data : Int) : Bool {
        if size = 0 then
            false
        else
            if head.getNext().getData() = data then
                {
                    head.setNext(head.getNext().getNext());
                    size <- size - 1;
                    true;
                }
            else
                let prev : ListNode <- head.getNext() in
                let current : ListNode <- head.getNext().getNext() in
                let found : Bool <- false in
                {
                    while (not (isvoid current)) loop
                        if current.getData() = data then
                            {
                                prev.setNext(current.getNext());
                                size <- size - 1;
                                found <- true;
                                current <- (new ListNode);  -- 终止循环
                            }
                        else
                            {
                                prev <- current;
                                current <- current.getNext();
                            }
                        fi
                    pool;
                    found;
                }
            fi
        fi
    };
    
    -- Search for a node with given data
    search(data : Int) : Bool {
        let current : ListNode <- head.getNext() in
        let found : Bool <- false in
        {
            while (not (isvoid current)) loop
                if current.getData() = data then
                    {
                        found <- true;
                        current <- (new ListNode);  -- 终止循环
                    }
                else
                    current <- current.getNext()
                fi
            pool;
            found;
        }
    };
    
    -- Check if list is empty
    isempty() : Bool { size = 0 };
    
    -- Get size of list
    getSize() : Int { size };
    
    -- Print the list (简化版本)
    printList() : Object {
        let current : ListNode <- head.getNext() in
        let io : IO <- new IO in
        {
            io.out_string("List: ");
            while (not (isvoid current)) loop
                {
                    io.out_int(current.getData());
                    current <- current.getNext();
                    if not (isvoid current) then
                        io.out_string(" -> ")
                    else
                        io.out_string(" -> NULL\n")
                    fi;
                }
            pool;
        }
    };
};

class Main {
    main() : Object {
        let list : LinkedList <- (new LinkedList).init() in
        let io : IO <- new IO in
        {
            io.out_string("=== Testing Linked List ===\n");
            
            -- Test isempty
            if list.isempty() then
                io.out_string("List is empty\n")
            else
                io.out_string("List is not empty\n")
            fi;
            
            -- Test insert
            list.insert(1);
            list.insert(2);
            list.insert(3);
            
            list.printList();
            io.out_string("Size: ");
            io.out_int(list.getSize());
            io.out_string("\n");
            
            -- Test search
            if list.search(2) then
                io.out_string("Found 2 in list\n")
            else
                io.out_string("Did not find 2 in list\n")
            fi;
            
            if list.search(5) then
                io.out_string("Found 5 in list\n")
            else
                io.out_string("Did not find 5 in list\n")
            fi;
            
            -- Test delete
            if list.delete(2) then
                io.out_string("Successfully deleted 2\n")
            else
                io.out_string("Failed to delete 2\n")
            fi;
            
            list.printList();
            io.out_string("Size after deletion: ");
            io.out_int(list.getSize());
            io.out_string("\n");
            
            -- Test isempty again
            if list.isempty() then
                io.out_string("List is empty\n")
            else
                io.out_string("List is not empty\n")
            fi;
        }
    };
};
