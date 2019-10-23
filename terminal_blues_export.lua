local directory='D:/Google Drive (7r4nm1nh@gmail.com)/Art/Digital/2019/Terminal Blues/'
local sprite=app.activeSprite

function export(sprite, directory, variant, equipment)
    local layer_bg=sprite.layers[3].layers[2]
    local prev_state_bg=layer_bg.isVisible
    layer_bg.isVisible=false

    local layer_equipment=sprite.layers[6].layers[1]
    local prev_state_equipment=layer_equipment.isVisible


    if equipment then
        layer_equipment.isVisible=true
        app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/equipment/mini16.bmp', slice="mini16" }
        app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/equipment/minif16.bmp', slice="minif16" }
    end

    layer_equipment.isVisible=false
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/alphabet_brass.bmp', slice="alphabet_brass" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/alphabet_classic.bmp', slice="alphabet_classic" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/alphabet_heavy.bmp', slice="alphabet_heavy" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/alphabet_light.bmp', slice="alphabet_light" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/alphabet_shadow.bmp', slice="alphabet_shadow" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/dungeon16.bmp', slice="dungeon16" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/mini16.bmp', slice="mini16" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/minif16.bmp', slice="minif16" }
    app.command.SaveFileCopyAs{ useUI="false", filename=directory..variant..'/gfx/sprite16.bmp', slice="sprite16" }

    layer_equipment.isVisible=prev_state_equipment

    layer_bg.isVisible=prev_state_bg
end

export(sprite, directory, 'blues', true)
--[[
export(sprite, 'D:/Games/Roguelikes/', 'powder118_win')
--]]
