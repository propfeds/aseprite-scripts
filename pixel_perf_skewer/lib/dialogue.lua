local function default(var, var_default)
    -- Does not mess with the falsey variables like the regular or
    if (type(var) == 'string' and var == '') or var == nil then
        return var_default
    end
    return var
end

dlg = Dialog('Pixel-Perfect Skewer')

:entry
{
    id = 'x_slope',
    label = 'x & y slopes:',
    text = tostring(default(cfg.x_slope, cfg_format.x_slope))
}
:entry
{
    id = 'y_slope',
    text = tostring(default(cfg.y_slope, cfg_format.y_slope))
}
:check
{
    id = 'wrap',
    label = 'Wrap around:',
    selected = default(cfg.wrap, cfg_format.wrap)
}
:label
{
    id = 'explanation_0',
    label = 'Explanation:',
    text = 'The skewer starts from the top-left corner,'
}
:newrow{}
:label
{
    id = 'explanation_1',
    text = 'and can only skew one axis at a time.'
}
:button
{
    id = 'ok',
    text = 'Skew!'
}
:button
{
    id = 'cancel',
    text = 'Cancel'
}