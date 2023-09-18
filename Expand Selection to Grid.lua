function expand()
    local sprite = app.activeSprite
    
    if not sprite then
        app.alert("There is no sprite to expand")
        return
    end

    local tileSize = sprite.gridBounds.width

    -- Top Left
    local x = sprite.selection.bounds.x
    local y = sprite.selection.bounds.y
    -- Bottom Right
    local x2 = x + sprite.selection.bounds.width
    local y2 = y + sprite.selection.bounds.height

    while (x % tileSize ~= 0) do x = x - 1 end
    while (y % tileSize ~= 0) do y = y - 1 end
    while (x2 % tileSize ~= 0) do x2 = x2 + 1 end
    while (y2 % tileSize ~= 0) do y2 = y2 + 1 end
    
    sprite.selection:add(Rectangle{ x = x, y = y, width = x2 - x, height = y2 - y })
end

app.transaction(
    function()
        expand()
    end
)