local sprite=app.activeSprite

app.transaction
(
    function()
        local alphabet_brass=sprite:newSlice(Rectangle(0, 0, 80, 96))
        alphabet_brass.name='alphabet_brass'
        local alphabet_classic=sprite:newSlice(Rectangle(80, 0, 80, 96))
        alphabet_classic.name='alphabet_classic'
        local alphabet_heavy=sprite:newSlice(Rectangle(160, 0, 80, 96))
        alphabet_heavy.name='alphabet_heavy'
        local alphabet_light=sprite:newSlice(Rectangle(240, 0, 80, 96))
        alphabet_light.name='alphabet_light'
        local alphabet_shadow=sprite:newSlice(Rectangle(320, 0, 80, 96))
        alphabet_shadow.name='alphabet_shadow'
        local dungeon16=sprite:newSlice(Rectangle(0, 96, 384, 208))
        dungeon16.name='dungeon16'
        local mini16=sprite:newSlice(Rectangle(0, 304, 384, 64))
        mini16.name='mini16'
        local minif16=sprite:newSlice(Rectangle(0, 368, 384, 64))
        minif16.name='minif16'
        local sprite16=sprite:newSlice(Rectangle(0, 432, 384, 96))
        sprite16.name='sprite16'
    end
)