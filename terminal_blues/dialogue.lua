local function default(var, var_default)
    if var==nil then
        return var_default
    else
        return var
    end
end

export_dlg=Dialog('Terminal Blues Export')

:check{label='Export:',
       id='repo_export', text='./export/ (Repository)',
       selected=default(config.repo.export, config_default.repo.export)}
:check{id='custom_export', text='Custom directory',
       selected=default(config.custom.export, config_default.custom.export),
       --[[onclick=function() TOGGLE DISPLAY of CUSTOM SETTINGS end]]}

:separator{text='Repository'}

:check{label='Palettes:',
       id='repo_blues', text='Blues',  selected=default(config.repo.palettes[1], config_default.repo.palettes[1])}
:check{id='repo_prot', text='Protea',  selected=default(config.repo.palettes[2], config_default.repo.palettes[2])}
:check{id='repo_deut', text='Deutzia', selected=default(config.repo.palettes[3], config_default.repo.palettes[3])}
:check{id='repo_trit', text='Tritoma', selected=default(config.repo.palettes[4], config_default.repo.palettes[4])}

:entry{label='Versions:',
       id='ver_blues', text=default(config.repo.versions[1], config_default.repo.versions[1])}
:entry{id='ver_prot',  text=default(config.repo.versions[2], config_default.repo.versions[2])}
:entry{id='ver_deut',  text=default(config.repo.versions[3], config_default.repo.versions[3])}
:entry{id='ver_trit',  text=default(config.repo.versions[4], config_default.repo.versions[4])}

:separator{text='Custom Directory'}

:entry{label='Directory:',
       id='custom_dir', text=default(config.custom.dir, config_default.custom.dir)}
:combobox{label='Palette:',
          id='custom_palette', option=default(config.custom.palette, config_default.custom.palette),
          options={'master', 'blues', 'prot', 'deut', 'trit'}}

:check{label='Options:',
       id='override', text='Override gfx', selected=default(config.custom.override, config_default.custom.override)}
:check{id='equipment', text='@ equipment', selected=default(config.custom.equipment, config_default.custom.equipment)}
:check{id='extra_alphabets', text='Extra alphabets',
    selected=default(config.custom.extra_alphabets, config_default.custom.extra_alphabets),
    --[[onclick=function() show_alphabets() end]]}

:entry{label='Fonts in:', 
       id='alph_in_1', text=default(config.custom.alph_in[1], config_default.custom.alph_in[1])}
:entry{id='alph_in_2', text=default(config.custom.alph_in[2], config_default.custom.alph_in[2])}
:entry{id='alph_in_3', text=default(config.custom.alph_in[3], config_default.custom.alph_in[3])}
:entry{id='alph_in_4', text=default(config.custom.alph_in[4], config_default.custom.alph_in[4])}
:entry{id='alph_in_5', text=default(config.custom.alph_in[5], config_default.custom.alph_in[5])}
:entry{label='Fonts out:', 
       id='alph_out_1', text=default(config.custom.alph_out[1], config_default.custom.alph_out[1])}
:entry{id='alph_out_2', text=default(config.custom.alph_out[2], config_default.custom.alph_out[2])}
:entry{id='alph_out_3', text=default(config.custom.alph_out[3], config_default.custom.alph_out[3])}
:entry{id='alph_out_4', text=default(config.custom.alph_out[4], config_default.custom.alph_out[4])}
:entry{id='alph_out_5', text=default(config.custom.alph_out[5], config_default.custom.alph_out[5])}

:separator{}

:button{id='ok', text='Export'}
:button{id='cancel', text='Cancel'}
