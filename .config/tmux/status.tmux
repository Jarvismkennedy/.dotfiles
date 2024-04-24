#!/usr/bin/bash
black="#191a1c"
bg0="#2c2d30"
bg1="#35373b"
bg2="#3e4045"
bg3="#404247"
bg_d="#242628"
bg_blue="#79b7eb"
bg_yellow="#e6cfa1"
fg="#b1b4b9"
purple="#c27fd7"
green="#99bc80"
orange="#c99a6e"
blue="#68aee8"
yellow="#dfbe81"
cyan="#5fafb9"
red="#e16d77"
grey="#646568"
light_grey="#8b8d91"
dark_cyan="#316a71"
dark_red="#914141"
dark_yellow="#8c6724"
dark_purple="#854897"
diff_add="#32352f"
diff_delete="#342f2f"
diff_change="#203444"
diff_text="#32526c"

bg=${yellow}
fg=${black}

tmux set-option -g status-left-length 100
tmux set-option -g status-left "#{?client_prefix,#[bg=${bg}],} #{?client_prefix,#[fg=${fg}]#S,#S} #{?client_prefix,#[bg=${bg}],}"



