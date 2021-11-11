-- Find Tab ref count & print the variable like _G/data/herodata/weapon/gun ,its can used for virtual tab,to find the reason why no gc

local findTableRefCount = 0
local findTableCount = 0
local lookFindedTable = {}
---
---recursion table to calc tab info & print the variable
---@private
---@param
---@return
function recursionTableRef(key,table,targetTab)
    if type(table) == 'table' then
        
        findTableCount = findTableCount + 1
        
        if table == targetTab then
            findTableRefCount = findTableRefCount + 1
        
            print(string.format("find ref variable：%s",key))
        else
            if lookFindedTable[table]  then
                return
            end

            lookFindedTable[table] = true

            for k, value in pairs(table) do
                if type(k) == "string" or type(k) == "number" then
                    RecursionTableRef(key.."/"..k,value,targetTab)
                end
            end
        end
    end
end

---
---find tab refcount.only find key  is string /number .ignore table is key
---@public
---@param targetTab table
---@return number
local function findTableRefCount(targetTab)

    if targetTab == nil then
        print("find tab is nil")
        return
    end

    findTableRefCount = 0
    findTableCount = 0
    lookFindedTable = {}
  
    recursionTableRef("_G",_G,targetTab)

    lookFindedTable = nil
  
    print(string.format("find result %s ref count is: %d",findTableCount,findTableRefCount))
    
    return findTableRefCount
end

return {
    FindTableRefCount = findTableRefCount
}
