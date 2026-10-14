import os
import math
from PIL import Image, ImageDraw, ImageFont, ImageFilter

def create_app_icon():
    size = 1024
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # Rounded rectangle background (Squircle style macOS icon)
    margin = 80
    bg_box = [margin, margin, size - margin, size - margin]
    radius = 190

    # Draw dark shadow
    shadow_offset = 30
    shadow = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    s_draw = ImageDraw.Draw(shadow)
    s_draw.rounded_rectangle([margin, margin + shadow_offset, size - margin, size - margin + shadow_offset], radius=radius, fill=(0, 0, 0, 140))
    shadow = shadow.filter(ImageFilter.GaussianBlur(35))
    img.paste(shadow, (0, 0), shadow)

    # Base squircle with dark carbon gradient
    base_mask = Image.new("L", (size, size), 0)
    b_draw = ImageDraw.Draw(base_mask)
    b_draw.rounded_rectangle(bg_box, radius=radius, fill=255)

    base = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    for y in range(margin, size - margin):
        ratio = (y - margin) / (size - 2 * margin)
        # Deep metallic obsidian gradient
        r = int(18 + ratio * 12)
        g = int(20 + ratio * 10)
        b = int(28 + ratio * 15)
        line = Image.new("RGBA", (size, 1), (r, g, b, 255))
        base.paste(line, (0, y))

    img.paste(base, (0, 0), base_mask)

    # Glowing red inner border / rim
    border = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    bd_draw = ImageDraw.Draw(border)
    bd_draw.rounded_rectangle(bg_box, radius=radius, outline=(255, 40, 60, 220), width=10)
    bd_draw.rounded_rectangle([margin + 12, margin + 12, size - margin - 12, size - margin - 12], radius=radius - 10, outline=(255, 80, 100, 70), width=4)
    img.paste(border, (0, 0), border)

    # Center Dragon / Keyboard glyph
    # Let's draw stylized mechanical keyboard layout and dragon emblem
    center_x = size // 2
    center_y = size // 2 - 20

    # Draw mechanical keyboard body (angled 60% representation)
    kb_w = 660
    kb_h = 240
    kb_x0 = center_x - kb_w // 2
    kb_y0 = center_y + 40
    kb_x1 = kb_x0 + kb_w
    kb_y1 = kb_y0 + kb_h

    # Keyboard base plate with glow
    kb_glow = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    kg_draw = ImageDraw.Draw(kb_glow)
    kg_draw.rounded_rectangle([kb_x0 - 15, kb_y0 - 15, kb_x1 + 15, kb_y1 + 15], radius=35, fill=(255, 30, 60, 90))
    kb_glow = kb_glow.filter(ImageFilter.GaussianBlur(25))
    img.paste(kb_glow, (0, 0), kb_glow)

    # Keyboard body
    draw.rounded_rectangle([kb_x0, kb_y0, kb_x1, kb_y1], radius=24, fill=(15, 17, 24, 255), outline=(255, 45, 75, 200), width=6)

    # Draw keys in a grid (60% keyboard rows)
    rows = 4
    cols = 12
    key_gap = 10
    total_gap_w = (cols + 1) * key_gap
    key_w = (kb_w - 40 - total_gap_w) // cols
    key_h = (kb_h - 30 - (rows + 1) * key_gap) // rows

    # Rainbow RGB wave color generator
    def get_rgb_color(c, r):
        hue = (c / cols * 0.8 + r / rows * 0.2) % 1.0
        # Convert HSV to RGB
        h_i = int(hue * 6)
        f = hue * 6 - h_i
        q = int(255 * (1 - f))
        t = int(255 * f)
        if h_i == 0: return (255, t, 40)
        elif h_i == 1: return (q, 255, 40)
        elif h_i == 2: return (40, 255, t)
        elif h_i == 3: return (40, q, 255)
        elif h_i == 4: return (t, 40, 255)
        else: return (255, 40, q)

    start_x = kb_x0 + 20 + key_gap
    start_y = kb_y0 + 15 + key_gap

    for r in range(rows):
        for c in range(cols):
            kx0 = start_x + c * (key_w + key_gap)
            ky0 = start_y + r * (key_h + key_gap)
            kx1 = kx0 + key_w
            ky1 = ky0 + key_h
            rgb = get_rgb_color(c, r)
            # Key body
            draw.rounded_rectangle([kx0, ky0, kx1, ky1], radius=6, fill=(28, 32, 44, 255), outline=(rgb[0], rgb[1], rgb[2], 210), width=3)
            # Key center glow
            draw.point((kx0 + key_w//2, ky0 + key_h//2), fill=(rgb[0], rgb[1], rgb[2], 255))

    # Dragon Emblem above keyboard
    dragon_y = center_y - 140
    # Dragon wing / head geometric polygon
    dragon_glow = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    dg_draw = ImageDraw.Draw(dragon_glow)
    
    # Polygon points for stylized sharp dragon crest
    points_left = [
        (center_x, dragon_y - 90),
        (center_x - 30, dragon_y - 50),
        (center_x - 110, dragon_y - 80),
        (center_x - 70, dragon_y - 20),
        (center_x - 130, dragon_y + 10),
        (center_x - 60, dragon_y + 35),
        (center_x - 110, dragon_y + 80),
        (center_x - 30, dragon_y + 60),
        (center_x, dragon_y + 100)
    ]
    points_right = [
        (center_x, dragon_y - 90),
        (center_x + 30, dragon_y - 50),
        (center_x + 110, dragon_y - 80),
        (center_x + 70, dragon_y - 20),
        (center_x + 130, dragon_y + 10),
        (center_x + 60, dragon_y + 35),
        (center_x + 110, dragon_y + 80),
        (center_x + 30, dragon_y + 60),
        (center_x, dragon_y + 100)
    ]
    dg_draw.polygon(points_left, fill=(255, 30, 60, 200))
    dg_draw.polygon(points_right, fill=(255, 30, 60, 200))
    dragon_glow = dragon_glow.filter(ImageFilter.GaussianBlur(20))
    img.paste(dragon_glow, (0, 0), dragon_glow)

    draw.polygon(points_left, fill=(240, 30, 55, 255), outline=(255, 120, 140, 255))
    draw.polygon(points_right, fill=(220, 20, 45, 255), outline=(255, 120, 140, 255))
    
    # Inner dragon cutouts
    inner_left = [(center_x - 10, dragon_y - 30), (center_x - 45, dragon_y), (center_x - 15, dragon_y + 30)]
    inner_right = [(center_x + 10, dragon_y - 30), (center_x + 45, dragon_y), (center_x + 15, dragon_y + 30)]
    draw.polygon(inner_left, fill=(18, 20, 28, 255))
    draw.polygon(inner_right, fill=(18, 20, 28, 255))

    # Badge text at bottom: K530 PRO
    # Draw simple clean text banner
    banner_w = 340
    banner_h = 56
    bx0 = center_x - banner_w // 2
    by0 = size - margin - 100
    draw.rounded_rectangle([bx0, by0, bx0 + banner_w, by0 + banner_h], radius=16, fill=(240, 30, 55, 240), outline=(255, 140, 160, 220), width=3)
    
    # Save master icon
    os.makedirs("/Users/adicadi/.gemini/antigravity/scratch/redragon-mac-studio/assets", exist_ok=True)
    icon_path = "/Users/adicadi/.gemini/antigravity/scratch/redragon-mac-studio/assets/icon_1024.png"
    img.save(icon_path, "PNG")
    print(f"Generated master icon at {icon_path}")

create_app_icon()

