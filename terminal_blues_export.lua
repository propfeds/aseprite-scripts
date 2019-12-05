function export(sprite, directory, equipment, extra_alphabets)
    local layer_folder_ref=sprite.layers[3]
    local prev_state_ref=layer_folder_ref.isVisible
    layer_folder_ref.isVisible=false

    local layer_equipment=sprite.layers[4].layers[3].layers[2]
    local prev_state_equipment=layer_equipment.isVisible
    if equipment then
        layer_equipment.isVisible=true
        app.command.SaveFileCopyAs{
            useUI='false',
            filename=directory..'equipment/mini16.bmp',
            slice='mini16'
        }
        app.command.SaveFileCopyAs{
            useUI='false',
            filename=directory..'equipment/minif16.bmp',
            slice='minif16'
        }
    end
    layer_equipment.isVisible=false

    app.command.SaveFileCopyAs{
        useUI='false',
        filename=directory..'alphabet_brass.bmp',
        slice='alphabet_brass'
    }
    app.command.SaveFileCopyAs{
        useUI='false',
        filename=directory..'alphabet_classic.bmp',
        slice='alphabet_classic'
    }
    app.command.SaveFileCopyAs{
        useUI='false',
        filename=directory..'alphabet_heavy.bmp',
        slice='alphabet_heavy'
    }
    app.command.SaveFileCopyAs{
        useUI='false',
        filename=directory..'alphabet_light.bmp',
        slice='alphabet_light'
    }
    app.command.SaveFileCopyAs{
        useUI='false',
        filename=directory..'alphabet_shadow.bmp',
        slice='alphabet_shadow'
    }
    app.command.SaveFileCopyAs{
        useUI='false',
        filename=directory..'dungeon16.bmp',
        slice='dungeon16'
    }
    app.command.SaveFileCopyAs{
        useUI='false',
        filename=directory..'mini16.bmp',
        slice='mini16'
    }
    app.command.SaveFileCopyAs{
        useUI='false',
        filename=directory..'minif16.bmp',
        slice='minif16'
    }
    app.command.SaveFileCopyAs{
        useUI='false',
        filename=directory..'sprite16.bmp',
        slice='sprite16'
    }

    local layer_extra_alphabets=sprite.layers[4].layers[1].layers[6]
    local prev_state_alphabets=layer_extra_alphabets.isVisible
    if extra_alphabets then
        layer_extra_alphabets.isVisible=true
        for i, layer in ipairs(layer_extra_alphabets.layers) do
            if layer.isVisible==true then
                app.command.SaveFileCopyAs{
                    useUI='false',
                    filename=directory..'extra_alphabets/alphabet_'..layer.name..'.bmp',
                    slice='alphabet_extra_'..layer.name
                }
            end
        end
    end
    layer_extra_alphabets.isVisible=prev_state_alphabets

    layer_folder_ref.isVisible=prev_state_ref
end

local project_directory=app.activeSprite.filename:match("(.*[/\\])")
export(app.activeSprite, project_directory..'export/blues/', true, true)
---[[
export(app.activeSprite, 'D:/Games/Roguelikes/powder118_win/gfx/', false, false)
--]]