function export(sprite, directory, variant)
    app.command.LayerVisibility(sprite.layers[1])

    sprite:crop(0, 304, 384, 64)
    sprite:saveCopyAs(directory..variant..'/equipment/mini16.bmp')
    app.command.Undo()

    sprite:crop(0, 368, 384, 64)
    sprite:saveCopyAs(directory..variant..'/equipment/minif16.bmp')
    app.command.Undo()

    app.command.LayerVisibility(sprite.layers[1])

    sprite:crop(0, 0, 80, 96)
    sprite:saveCopyAs(directory..variant..'/gfx/alphabet_brass.bmp')
    app.command.Undo()

    sprite:crop(80, 0, 80, 96)
    sprite:saveCopyAs(directory..variant..'/gfx/alphabet_classic.bmp')
    app.command.Undo()

    sprite:crop(160, 0, 80, 96)
    sprite:saveCopyAs(directory..variant..'/gfx/alphabet_heavy.bmp')
    app.command.Undo()

    sprite:crop(240, 0, 80, 96)
    sprite:saveCopyAs(directory..variant..'/gfx/alphabet_light.bmp')
    app.command.Undo()

    sprite:crop(320, 0, 80, 96)
    sprite:saveCopyAs(directory..variant..'/gfx/alphabet_shadow.bmp')
    app.command.Undo()

    sprite:crop(0, 96, 384, 208)
    sprite:saveCopyAs(directory..variant..'/gfx/dungeon16.bmp')
    app.command.Undo()

    sprite:crop(0, 304, 384, 64)
    sprite:saveCopyAs(directory..variant..'/gfx/mini16.bmp')
    app.command.Undo()

    sprite:crop(0, 368, 384, 64)
    sprite:saveCopyAs(directory..variant..'/gfx/minif16.bmp')
    app.command.Undo()

    sprite:crop(0, 432, 384, 96)
    sprite:saveCopyAs(directory..variant..'/gfx/sprite16.bmp')
    app.command.Undo()
end

local directory='D:/Internet Explorer/Lock/Hobbies/Fine Art/Digital/[2019]/Terminal Blues - A Powder Tileset/'
local sprite=app.activeSprite

export(sprite, directory, 'blues')
--[[
export(sprite, 'D:/Games/Roguelikes/', 'powder118_win')
--]]