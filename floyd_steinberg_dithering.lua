function nearest_colour_raw(r, g, b, palette)
    local idx=0
    local dist_min=1000000007
    local col_ref=0
    local dist=0
    local dr=0
    local dg=0
    local db=0
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
    for x=-1, image.width
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
        -- Horizontal quantisation runs like a snake so we don't need to account for that
        quant_err_r=quant_err_r+buffer_v_r[-1]+buffer_v_r[image.width]
        quant_err_g=quant_err_g+buffer_v_g[-1]+buffer_v_g[image.width]
        quant_err_b=quant_err_b+buffer_v_b[-1]+buffer_v_b[image.width]
        if y&1
        then
            for x=0, image.width-1
            do
                col_old=image:getPixel(x, y)
                nr=(col_old&0xff)+buffer_h_r+buffer_v_r[x]
                ng=((col_old>>8)&0xff)+buffer_h_g+buffer_v_g[x]
                nb=((col_old>>16)&0xff)+buffer_h_b+buffer_v_b[x]
                col_new=nearest_colour(nr, ng, nb, palette)
                image:drawPixel(x, y, col_new)
                quant_err_r=quant_err_r+(nr-(col_new&0xff))
                quant_err_g=quant_err_g+(ng-((col_new>>8)&0xff))
                quant_err_b=quant_err_b+(nb-((col_new>>16)&0xff))

                buffer_h_r=quant_err_r*7/16
                buffer_h_g=quant_err_g*7/16
                buffer_h_b=quant_err_b*7/16
                quant_err_r=quant_err_r-buffer_h_r
                quant_err_g=quant_err_g-buffer_h_g
                quant_err_b=quant_err_b-buffer_h_b

                buffer_vn_r[x+1]=quant_err_r*1/16
                buffer_vn_g[x+1]=quant_err_g*1/16
                buffer_vn_b[x+1]=quant_err_b*1/16
                quant_err_r=quant_err_r-buffer_vn_r[x+1]
                quant_err_g=quant_err_g-buffer_vn_g[x+1]
                quant_err_b=quant_err_b-buffer_vn_b[x+1]

                buffer_vn_r[x]=quant_err_r*5/16
                buffer_vn_g[x]=quant_err_g*5/16
                buffer_vn_b[x]=quant_err_b*5/16
                quant_err_r=quant_err_r-buffer_vn_r[x]
                quant_err_g=quant_err_g-buffer_vn_g[x]
                quant_err_b=quant_err_b-buffer_vn_b[x]

                buffer_vn_r[x-1]=quant_err_r*3/16
                buffer_vn_g[x-1]=quant_err_g*3/16
                buffer_vn_b[x-1]=quant_err_b*3/16
                quant_err_r=quant_err_r-buffer_vn_r[x-1]
                quant_err_g=quant_err_g-buffer_vn_g[x-1]
                quant_err_b=quant_err_b-buffer_vn_b[x-1]
            end
        else
            for x=image.width-1, 0, -1
            do
                col_old=image:getPixel(x, y)
                nr=(col_old&0xff)+buffer_h_r+buffer_v_r[x]
                ng=((col_old>>8)&0xff)+buffer_h_g+buffer_v_g[x]
                nb=((col_old>>16)&0xff)+buffer_h_b+buffer_v_b[x]
                col_new=nearest_colour(nr, ng, nb, palette)
                image:drawPixel(x, y, col_new)
                quant_err_r=quant_err_r+(nr-(col_new&0xff))
                quant_err_g=quant_err_g+(ng-((col_new>>16)&0xff))
                quant_err_b=quant_err_b+(nb-((col_new>>8)&0xff))
                
                buffer_h_r=quant_err_r*7/16
                buffer_h_g=quant_err_g*7/16
                buffer_h_b=quant_err_b*7/16
                quant_err_r=quant_err_r-buffer_h_r
                quant_err_g=quant_err_g-buffer_h_g
                quant_err_b=quant_err_b-buffer_h_b

                buffer_vn_r[x-1]=quant_err_r*1/16
                buffer_vn_g[x-1]=quant_err_g*1/16
                buffer_vn_b[x-1]=quant_err_b*1/16
                quant_err_r=quant_err_r-buffer_vn_r[x-1]
                quant_err_g=quant_err_g-buffer_vn_g[x-1]
                quant_err_b=quant_err_b-buffer_vn_b[x-1]

                buffer_vn_r[x]=quant_err_r*5/16
                buffer_vn_g[x]=quant_err_g*5/16
                buffer_vn_b[x]=quant_err_b*5/16
                quant_err_r=quant_err_r-buffer_vn_r[x]
                quant_err_g=quant_err_g-buffer_vn_g[x]
                quant_err_b=quant_err_b-buffer_vn_b[x]

                buffer_vn_r[x+1]=quant_err_r*3/16
                buffer_vn_g[x+1]=quant_err_g*3/16
                buffer_vn_b[x+1]=quant_err_b*3/16
                quant_err_r=quant_err_r-buffer_vn_r[x+1]
                quant_err_g=quant_err_g-buffer_vn_g[x+1]
                quant_err_b=quant_err_b-buffer_vn_b[x+1]
            end
        end
    end
end

local image=app.activeImage
local palette=app.activeSprite.palettes[1]
collectgarbage()
collectgarbage("setpause", 150)
floyd_steinberg_dither(image, palette)
collectgarbage("setpause", 100)