hl.curve("snappy", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
hl.curve("softPop", { type = "bezier", points = { { 0.1, 0.9 }, { 0.2, 1 } } })
hl.curve("slideIn", { type = "bezier", points = { { 0.15, 0.85 }, { 0.25, 1 } } })

-- Windows
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "snappy", style = "popin 85%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "softPop", style = "popin 88%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "snappy", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "snappy" })

-- Fading
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "snappy" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "softPop" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "snappy" })

-- Borders
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "snappy" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 4, bezier = "snappy" })

-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "slideIn", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "softPop", style = "slidevert" })
