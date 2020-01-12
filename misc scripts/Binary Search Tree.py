class BST:
    def __init__(self):
        self.root=None

    def setRoot(self,data):
        self.root=Node(data)

    def get(self):
        return self.key

    def getChildren(self):
        children=[]
        if self.left!=None:
            children.append(self.left)
        if self.right!=None:
            children.append(self.right)
        return children
    

class Node:

    def __init__(self,data):
        self.left=None
        self.right=None
        self.key=data

    def preTraverse(self):
        if x!=None:
            print(self.key)
            preTraverse(self.left)
            preTraverse(self.right)

    def postTraverse(self,data):
        if self!=None:
            postTraverse(self.left)
            postTraverse(self.right)
            print(self.key)

    def orderTraverse(self):
        if self!=None:
            orderTraverse(self.left)
            print(self.key)
            orderTraverse(self.right)

    def treeSearch(self,k):
        if self!=None or self==self.key:
            return self.key
        if k<self.key:
            return treeSearch(self.left,k)
        else:
            return treeSearch(self.right,k)
        
    def insert(self,data):
        if self.key!=None:
            if data<self.key:
                if self.left==None:
                    self.left=Node(data)
                else: self.left.insert(data)
            elif data>self.key:
                if self.right==None: self.right=Node(data)
                else: self.right.insert(data)
        else: self.key=data
