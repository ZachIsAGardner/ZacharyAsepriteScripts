-- Resize Tiles
function resize(sprite, fromTileSize, toTileSize, origin)

    local rows = math.floor(sprite.height / fromTileSize)
    local columns = math.floor(sprite.width / fromTileSize)

    if (toTileSize > fromTileSize) then
        app.command.CanvasSize {
            ui = false,
            bounds = Rectangle(0, 0, columns * toTileSize, rows * toTileSize)
        }
    end

    function move(c, r)
        -- Bigger
        if (toTileSize > fromTileSize) then
            -- Make Selection
            sprite.selection:select(Rectangle((columns - 1 - c) * fromTileSize, (rows - 1 - r) * fromTileSize,
                fromTileSize, fromTileSize))

            -- Move

            if (origin == "bottom") then
                local right = ((toTileSize - fromTileSize) / 2) + ((columns - 1 - c) * (toTileSize - fromTileSize))
                if (right > 0) then
                    app.command.MoveMask {
                        target = 'content',
                        wrap = false,
                        direction = 'right',
                        units = 'pixel',
                        quantity = right
                    }
                end

                local down = ((toTileSize - fromTileSize) * (rows - 1 - r)) + ((toTileSize - fromTileSize))
                if (down > 0) then
                    app.command.MoveMask {
                        target = 'content',
                        wrap = false,
                        direction = 'down',
                        units = 'pixel',
                        quantity = down
                    }
                end
            end

            -- Center
            if (origin == "center") then
                local right = ((toTileSize - fromTileSize) / 2) + ((columns - 1 - c) * (toTileSize - fromTileSize))
                if (right > 0) then
                    app.command.MoveMask {
                        target = 'content',
                        wrap = false,
                        direction = 'right',
                        units = 'pixel',
                        quantity = right
                    }
                end

                local down = ((toTileSize - fromTileSize) * (rows - 1 - r)) + ((toTileSize - fromTileSize) / 2)
                if (down > 0) then
                    app.command.MoveMask {
                        target = 'content',
                        wrap = false,
                        direction = 'down',
                        units = 'pixel',
                        quantity = down
                    }
                end
            end

            -- Top
            if (origin == "top") then
                local right = ((toTileSize - fromTileSize) / 2) + ((columns - 1 - c) * (toTileSize - fromTileSize))
                if (right > 0) then
                    app.command.MoveMask {
                        target = 'content',
                        wrap = false,
                        direction = 'right',
                        units = 'pixel',
                        quantity = right
                    }
                end

                local down = ((toTileSize - fromTileSize) * (rows - 1 - r))
                if (down > 0) then
                    app.command.MoveMask {
                        target = 'content',
                        wrap = false,
                        direction = 'down',
                        units = 'pixel',
                        quantity = down
                    }
                end
            end
        else
            -- Make Selection
            sprite.selection:select(Rectangle(c * fromTileSize, r * fromTileSize, fromTileSize, fromTileSize))
            
            -- Move

            -- Bottom
            if (origin == "bottom") then
                local left = ((fromTileSize - toTileSize) / 2) + (c * (fromTileSize - toTileSize))
               
                app.command.MoveMask {
                    target = 'content',
                    wrap = false,
                    direction = 'left',
                    units = 'pixel',
                    quantity = left
                }
                
                local up = ((fromTileSize - toTileSize) * r) + ((fromTileSize - toTileSize) / 4)
                
                app.command.MoveMask {
                    target = 'content',
                    wrap = false,
                    direction = 'up',
                    units = 'pixel',
                    quantity = up
                }
            end
            
            -- Center
            if (origin == "center") then
                local left = ((fromTileSize - toTileSize) / 2) + (c * (fromTileSize - toTileSize))
               
                app.command.MoveMask {
                    target = 'content',
                    wrap = false,
                    direction = 'left',
                    units = 'pixel',
                    quantity = left
                }
                
                local up = ((fromTileSize - toTileSize) * r) + ((fromTileSize - toTileSize) / 2)
                
                app.command.MoveMask {
                    target = 'content',
                    wrap = false,
                    direction = 'up',
                    units = 'pixel',
                    quantity = up
                }
            end

            -- Top
            if (origin == "top") then
                local left = ((fromTileSize - toTileSize) / 2) + (c * (fromTileSize - toTileSize))
               
                app.command.MoveMask {
                    target = 'content',
                    wrap = false,
                    direction = 'left',
                    units = 'pixel',
                    quantity = left
                }
                
                local up = ((fromTileSize - toTileSize) * r) + ((fromTileSize - toTileSize) / 2) + ((fromTileSize - toTileSize) / 4)
                
                app.command.MoveMask {
                    target = 'content',
                    wrap = false,
                    direction = 'up',
                    units = 'pixel',
                    quantity = up
                }
            end
        end

        sprite.selection:deselect()
        app.command.DeselectMask()
    end

    for r = 0, rows - 1 do
        for c = 0, columns - 1 do
            move(c, r)
        end
    end

    if (toTileSize < fromTileSize) then
        app.command.CanvasSize {
            ui = false,
            bounds = Rectangle(0, 0, columns * toTileSize, rows * toTileSize)
        }
    end
    sprite.gridBounds = Rectangle(0, 0, toTileSize, toTileSize)
end

function dialog(sprite)
    local d = Dialog("Resize Sprite Sheet")
    d:number{
        id = "fromTileSize",
        label = "From Tile Size:",
        text = tostring(sprite.gridBounds.width),
        focus = true
    }:number{
        id = "toTileSize",
        label = "To Tile Size:",
        text = tostring(sprite.gridBounds.width * 2)
    }
    -- :combobox{
    --     id = "origin",
    --     label = "Origin:",
    --     option = "center",
    --     options = {"bottom", "center", "top"}
    -- }
    :button{
        id = "ok",
        text = "&OK",
        focus = true
    }:button{
        text = "&Cancel"
    }:show()

    local data = d.data;
    return data;
end

app.transaction(function()
    local sprite = app.activeSprite

    if not sprite then
        app.alert("There is no sprite to resize")
        return
    end

    data = dialog(sprite)
    if (data.ok) then
        resize(sprite, data.fromTileSize, data.toTileSize, "center")
    end
end)
