BTree = {}

BTree.arrRoots = {}
BTree.inited = false;

local SequenceNodeName = "SequenceNode";
local SelectNodeName = "SelectNode";
local ParallelNodeName = "ParallelNode";
local ActionNodeName = "ActionNode";


local sequenceNode = {}
sequenceNode.__index = sequenceNode;
sequenceNode.name = SequenceNodeName;
sequenceNode.children = nil;
sequenceNode.__complete = false;
sequenceNode.__isRoot = false;
function sequenceNode:Add(node)
    BTree.checkNodeValid(node)
    if self.children == nil then
        self.children = {}
    end
    table.insert(self.children,node);
end
function sequenceNode:checkComplete()
    if self.children then
        self.__complete = true;
        for i=1,#self.children do
            if not self.children[i].__complete then
                self.__complete = false;
                break;
            end
        end
    else
        self.__complete = true;
    end
end
function sequenceNode:refresh()
    if not self.__complete then
        if self.children then
            for i=1,#self.children do
                if not self.children[i].__complete then
                    self.children[i]:refresh();
                    break;
                end
            end
        end
        self:checkComplete();
    end
end
function sequenceNode:Destroy()
    self.__complete = true;
end


local parallelNode = {}
parallelNode.__index = parallelNode;
parallelNode.name = ParallelNodeName;
parallelNode.children = nil;
parallelNode.__complete = false;
parallelNode.__isRoot = false;
function parallelNode:Add(node)
    BTree.checkNodeValid(node)
    if self.children == nil then
        self.children = {}
    end
    table.insert(self.children,node);
end
function parallelNode:checkComplete()
    if self.children then
        self.__complete = true;
        for i=1,#self.children do
            if not self.children[i].__complete then
                self.__complete = false;
                break;
            end
        end
    else
        self.__complete = true;
    end
end
function parallelNode:refresh()
    if not self.__complete then
        if self.children then
            for i=1,#self.children do
                if not self.children[i].__complete then
                    self.children[i]:refresh();
                end
            end
        end
        self:checkComplete();
    end
end
function parallelNode:Destroy()
    self.__complete = true;
end


local selectNode = {}
selectNode.__index = selectNode;
selectNode.name = SelectNodeName;
selectNode.children = nil;
selectNode.__complete = false;
selectNode.__isRoot = false;
function selectNode:Add(node)
    BTree.checkNodeValid(node)
    if self.children == nil then
        self.children = {}
    end
    table.insert(self.children,node);
end
function selectNode:checkComplete()
    if self.children then
        self.__complete = false;
        for i=1,#self.children do
            if self.children[i].__complete then
                self.__complete = true;
                break;
            end
        end
    else
        self.__complete = true;
    end
end
function selectNode:refresh()
    if not self.__complete then
        if self.children then
            for i=1,#self.children do
                if not self.children[i].__complete then
                    self.children[i]:refresh();
                end
            end
        end
        self:checkComplete();
    end
end
function selectNode:Destroy()
    self.__complete = true;
end


local actionNode = {}
actionNode.__index = actionNode;
actionNode.name = ActionNodeName;
actionNode.__complete = false;
actionNode.__isRoot = false;
function actionNode:refresh()
    if not self.__complete then
        if self.func then
            self.__complete = self.func();
        else
            self.__complete = true;
        end
    end
end
function actionNode:Add()
    error("can't add subnode to actionNode!")
end
function actionNode:Destroy()
    self.__complete = true;
end



function BTree.checkNodeValid(node)
    assert(node~=nil,"null node!")
    assert(not node.__isRoot,"node child can't be root!")
    assert(node.name == SequenceNodeName or node.name == SelectNodeName or node.name == ParallelNodeName or node.name == ActionNodeName,"unsupported node!");
end
function BTree.update()
    if #BTree.arrRoots > 0 then
        for i=#BTree.arrRoots,1,-1 do
            local root = BTree.arrRoots[i];
            if root.__complete then
                table.remove(BTree.arrRoots,i);
            end
        end
        for i=1,#BTree.arrRoots do
            local root = BTree.arrRoots[i];
            if not root.__complete then
                root:refresh();
            end
        end
    end
end




--------------------------public static
function BTree.Init()
    if not BTree.inited then
        BTree.inited = true;
        UpdateBeat:Add(BTree.update);
    end
end
function BTree.CreateSequenceNode(isRoot)
    local ret = {};
    setmetatable(ret,sequenceNode);
    ret.__isRoot = isRoot;
    if isRoot then
        table.insert(BTree.arrRoots,ret);
    end
    return ret;
end
function BTree.CreateParallelNode(isRoot)
    local ret = {};
    setmetatable(ret,parallelNode);
    ret.__isRoot = isRoot;
    if isRoot then
        table.insert(BTree.arrRoots,ret);
    end
    return ret;
end
function BTree.CreateSelectNode(isRoot)
    local ret = {};
    setmetatable(ret,selectNode);
    ret.__isRoot = isRoot;
    if isRoot then
        table.insert(BTree.arrRoots,ret);
    end
    return ret;
end
function BTree.CreateActionNode(func,isRoot)
    local ret = {};
    setmetatable(ret,actionNode);
    ret.__isRoot = isRoot;
    ret.func = func;
    if isRoot then
        table.insert(BTree.arrRoots,ret);
    end
    return ret;
end
function BTree.CreateTimerNode(duration,isRoot)
    local ret = {};
    setmetatable(ret,actionNode);
    ret.__isRoot = isRoot;
    local time = 0;
    ret.func = function()
        time = time + Time.deltaTime;
        return time >= duration;
    end;
    if isRoot then
        table.insert(BTree.arrRoots,ret);
    end
    return ret;
end
--------------------------end public