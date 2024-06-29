dofile('lib/alerts.lua')

local sprite = app.sprite

if sprite == nil then
    app.alert(alerts.no_active_sprite)
    return
end

dofile('lib/script_path.lua')
dofile('lib/table_persistence.lua')

-- Only format
cfg_format =
{
    x_slope = 0,
    y_slope = 0,
    wrap = false
}

cfg = persistence.load(script_path()..'config.lua')
if cfg == nil then
    cfg = {}
end

dofile('lib/dialogue.lua')

dlg:show()

local MODE_X = true
local MODE_Y = true

local dat = dlg.data
if dat.ok then
    local x_slope = tonumber(dat.x_slope)
    if x_slope == nil then
        app.alert(alerts.x_nil)
        MODE_X = false
    elseif x_slope == 0 then
        MODE_X = false
    end

    local x_slope_abs = math.abs(x_slope)
    local h_dir = 'right'
    if x_slope < 0 then
        h_dir = 'left'
    end

    local y_slope = tonumber(dat.y_slope)
    if y_slope == nil then
        app.alert(alerts.y_nil)
        MODE_Y = false
    elseif y_slope == 0 then
        MODE_Y = false
    end

    local y_slope_abs = math.abs(y_slope)
    local v_dir = 'down'
    if y_slope < 0 then
        v_dir = 'up'
    end

    local bounds = sprite.selection.bounds
    -- Has x, y, width, height

    app.transaction(
        function()
            app.command.DeselectMask()
            if MODE_X then
                for y = 1, bounds.height-1 do
                    sprite.selection:select(bounds.x, bounds.y + y, bounds.width, 1)
                    app.command.MoveMask
                    {
                        target = 'content',
                        wrap = dat.wrap,
                        direction = h_dir,
                        units = 'pixel',
                        quantity = math.floor(y/x_slope_abs + 0.5)
                    }
                    app.command.DeselectMask()
                end
            elseif MODE_Y then
                for x = 1, bounds.width-1 do
                    sprite.selection:select(bounds.x + x, bounds.y, 1, bounds.height)
                    app.command.MoveMask
                    {
                        target = 'content',
                        wrap = dat.wrap,
                        direction = v_dir,
                        units = 'pixel',
                        quantity = math.floor(x/y_slope_abs + 0.5)
                    }
                    app.command.DeselectMask()
                end
            end
            sprite.selection:select(bounds)
        end
    )

    persistence.store(script_path()..'config.lua',
    {
        x_slope = x_slope,
        y_slope = y_slope,
        wrap = dat.wrap
    })
    app.alert(alerts.complete)
end