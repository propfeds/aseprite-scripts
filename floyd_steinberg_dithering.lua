function nearest_colour_raw(r, g, b, palette)
    local idx=0
    local dist_min=1000000007
    local col_ref=0
    local dist=0
    for i=0, #palette-1
    do
        col_ref=palette:getColor(i).rgbaPixel
        dr=(col_ref&0xff)-r
        dg=((col_ref>>8)&0xff)-g
        db=((col_ref>>16)&0xff)-b
        dist=dr*dr+dg*dg+db*db
        if dist<dist_min
        then
            dist_min=dist
            idx=i
        end
    end
    return palette:getColor(idx).rgbaPixel
end
function floyd_steinberg_dither(image, palette)
    local nearest_colour=nearest_colour_raw
    -- Either Lua is fucking bad at garbage collection, or Aseprite is.
    local dr=0
    local dg=0
    local db=0
    local nr=0
    local ng=0
    local nb=0
    local col_old=0
    local col_new=0
    -- This algorithm really wants to ensure minimum quantisation error.
    local quant_err_r=0
    local quant_err_g=0
    local quant_err_b=0
    -- Horizontal buffers: Only one pixel
    local buffer_h_r=0
    local buffer_h_g=0
    local buffer_h_b=0
    -- Vertical buffers: Two rows instead of the whole picture. vn: Vertical Next (Row)
    local buffer_v_r={}
    local buffer_v_g={}
    local buffer_v_b={}
    local buffer_vn_r={}
    local buffer_vn_g={}
    local buffer_vn_b={}
    for x=0, image.width-1
    do
        buffer_v_r[x]=0
        buffer_v_g[x]=0
        buffer_v_b[x]=0
        buffer_vn_r[x]=0
        buffer_vn_g[x]=0
        buffer_vn_b[x]=0
    end
    -- The loop: Sweep left->right then right->left alternating
    for y=0, image.height-1
    do
        -- Pushing down the drain
        for x=0, image.width-1
        do
            buffer_v_r[x]=buffer_vn_r[x]
            buffer_v_g[x]=buffer_vn_g[x]
            buffer_v_b[x]=buffer_vn_b[x]
        end
        if y&1
        then
            for x=0, image.width-1
            do
                if not x -- Equiv to x==0
                then
                    buffer_h_r=0
                    buffer_h_g=0
                    buffer_h_b=0
                end
                col_old=image:getPixel(x, y)
                nr=(col_old&0xff)+buffer_h_r+buffer_v_r[x]
                ng=((col_old>>8)&0xff)+buffer_h_g+buffer_v_g[x]
                nb=((col_old>>16)&0xff)+buffer_h_b+buffer_v_b[x]
                col_new=nearest_colour(nr, ng, nb, palette)
                image:drawPixel(x, y, col_new)
                quant_err_r=quant_err_r+(nr-(col_new&0xff))
                quant_err_g=quant_err_g+(ng-((col_new>>8)&0xff))
                quant_err_b=quant_err_b+(nb-((col_new>>16)&0xff))

                dr=quant_err_r*7/16
                dg=quant_err_g*7/16
                db=quant_err_b*7/16
                buffer_h_r=dr
                buffer_h_g=dg
                buffer_h_b=db
                quant_err_r=quant_err_r-dr
                quant_err_g=quant_err_g-dg
                quant_err_b=quant_err_b-db

                dr=quant_err_r*1/16
                dg=quant_err_g*1/16
                db=quant_err_b*1/16
                buffer_vn_r[x+1]=dr
                buffer_vn_g[x+1]=dg
                buffer_vn_b[x+1]=db
                quant_err_r=quant_err_r-dr
                quant_err_g=quant_err_g-dg
                quant_err_b=quant_err_b-db
            
                dr=quant_err_r*5/16
                dg=quant_err_g*5/16
                db=quant_err_b*5/16
                buffer_vn_r[x]=dr
                buffer_vn_g[x]=dg
                buffer_vn_b[x]=db
                quant_err_r=quant_err_r-dr
                quant_err_g=quant_err_g-dg
                quant_err_b=quant_err_b-db

                dr=quant_err_r*3/16
                dg=quant_err_g*3/16
                db=quant_err_b*3/16
                buffer_vn_r[x-1]=dr
                buffer_vn_g[x-1]=dg
                buffer_vn_b[x-1]=db
                quant_err_r=quant_err_r-dr
                quant_err_g=quant_err_g-dg
                quant_err_b=quant_err_b-db
            end
        else
            for x=image.width-1, 0, -1
            do
                if x==image.width-1
                then
                    buffer_h_r=0
                    buffer_h_g=0
                    buffer_h_b=0
                end
                col_old=image:getPixel(x, y)
                nr=(col_old&0xff)+buffer_h_r+buffer_v_r[x]
                ng=((col_old>>8)&0xff)+buffer_h_g+buffer_v_g[x]
                nb=((col_old>>16)&0xff)+buffer_h_b+buffer_v_b[x]
                col_new=nearest_colour(nr, ng, nb, palette)
                image:drawPixel(x, y, col_new)
                quant_err_r=quant_err_r+(nr-(col_new&0xff))
                quant_err_g=quant_err_g+(ng-((col_new>>16)&0xff))
                quant_err_b=quant_err_b+(nb-((col_new>>8)&0xff))
                
                dr=quant_err_r*7/16
                dg=quant_err_g*7/16
                db=quant_err_b*7/16
                buffer_h_r=dr
                buffer_h_g=dg
                buffer_h_b=db
                quant_err_r=quant_err_r-dr
                quant_err_g=quant_err_g-dg
                quant_err_b=quant_err_b-db

                dr=quant_err_r*1/16
                dg=quant_err_g*1/16
                db=quant_err_b*1/16
                buffer_vn_r[x-1]=dr
                buffer_vn_g[x-1]=dg
                buffer_vn_b[x-1]=db
                quant_err_r=quant_err_r-dr
                quant_err_g=quant_err_g-dg
                quant_err_b=quant_err_b-db
            
                dr=quant_err_r*5/16
                dg=quant_err_g*5/16
                db=quant_err_b*5/16
                buffer_vn_r[x]=dr
                buffer_vn_g[x]=dg
                buffer_vn_b[x]=db
                quant_err_r=quant_err_r-dr
                quant_err_g=quant_err_g-dg
                quant_err_b=quant_err_b-db

                dr=quant_err_r*3/16
                dg=quant_err_g*3/16
                db=quant_err_b*3/16
                buffer_vn_r[x+1]=dr
                buffer_vn_g[x+1]=dg
                buffer_vn_b[x+1]=db
                quant_err_r=quant_err_r-dr
                quant_err_g=quant_err_g-dg
                quant_err_b=quant_err_b-db
            end
        end
    end
end

local image=app.activeImage
local palette=app.activeSprite.palettes[1]
floyd_steinberg_dither(image, palette)
collectgarbage()