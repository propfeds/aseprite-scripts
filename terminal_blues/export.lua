local sprite=app.activeSprite

if not sprite then
    app.alert{title='Error', text='Active sprite is nil. Export what?'}
    return
end

local project_dir=sprite.filename:match("(.*[/\\])")

config_default={
    repo={
        export=true,
        palettes={
            true,
            true,
            true,
            false
        },
        versions={
            '1.1b6',
            '0.07',
            '0.02',
            '0'
        }
    },
    custom={
        export=false,
        dir=project_dir..'custom_export/',
        palette='master',
        override=true,
        equipment=true,
        extra_alphabets=false,
        alph_in={},
        alph_out={}
    }
}

dofile('lib/table_persistence.lua')

config=persistence.load(project_dir..'data/config.lua')
if config==nil then
    config={
        repo={
            palettes={},
            versions={}
        },
        custom={
            alph_in={},
            alph_out={}
        }
    }
end

--[[Fine, it only needs to shallow copy anyway
local function defaultify(tbl, tbl_def)
    for key, value in pairs(tbl_def) do
        print(key, value)
        if type(value)=='table' then
            if value==nil then
                tbl[key]={}
            end
            defaultify(tbl[key], tbl_def[key])
        elseif value==nil then
            tbl[key]=tbl_def[key]
        end
    end
end

defaultify(config, config_default)
--]]

dofile('dialogue.lua')

export_dlg:show()

if export_dlg.data.ok then
    persistence.store(project_dir..'data/config.lua', config)
end