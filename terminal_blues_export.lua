local directory='D:/Google Drive (7r4nm1nh@gmail.com)/Art/Digital/2019/Terminal Blues/'
local sprite=app.activeSprite

function export(sprite, directory, variant, equipment)
    if equipment
    then
        local equipment_layer=sprite.layers[7].layers[1]
        local prev_visible_state=equipment_layer.isVisible
        equipment_layer.isVisible=true
        app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/equipment/mini16.bmp', slice="mini16" }
        app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/equipment/minif16.bmp', slice="minif16" }
        equipment_layer.isVisible=false
    end
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/alphabet_brass.bmp', slice="alphabet_brass" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/alphabet_classic.bmp', slice="alphabet_classic" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/alphabet_heavy.bmp', slice="alphabet_heavy" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/alphabet_light.bmp', slice="alphabet_light" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/alphabet_shadow.bmp', slice="alphabet_shadow" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/dungeon16.bmp', slice="dungeon16" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/mini16.bmp', slice="mini16" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/minif16.bmp', slice="minif16" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/sprite16.bmp', slice="sprite16" }
end

export(sprite, directory, 'blues')
--[[
export(sprite, 'D:/Games/Roguelikes/', 'powder118_win')
--]]