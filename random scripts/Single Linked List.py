class Node:
    def __init__(self,data):
        self.data=data
        self.next=None
        
    def getData(self):
        return self.data

    def getNext(self):
        return self.next

    def setData(self,newdata):
        self.data=newdata

    def setNext(self,newnext):
        self.next=newnext

class List:

    def __init__(self):
        self.head=None

    def isEmpty(self):
        return self.head==None

    def add(self,item):
        temp=Node(item)
        temp.setNext(self.head)
        self.head=temp
        
    def size(self):
        current=self.head
        count=0
        while current!=None:
            count+=1
            current=current.getNext()
        return count

    def search(self,item):
        current=self.head
        found=False
        while current!=None and not found:
            if current.getData()==item:
                found=True
            else:
                current=current.getNext()
        return found

    def remove(self,item):
        current=self.head
        prev=None
        found=False
        while not found:
            if current.getData()==item:
                found=True
            else:
                prev=current
                current=current.getNext()

        if prev==None:
            self.head=current.getNext()
        else:
            prev.setNext(current.getNext())

    def __str__(self):
        s=[]
        p=self.head
        if p!=None:
            while p.next!=None:
                s.append(p.data)
                p=p.next
            s.append(p.data)
        else:
            return 'List is empty'
        
        return str(s)
