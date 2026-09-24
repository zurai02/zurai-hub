--!optimise 2
--!strict
--!native

--[===========================================================[
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡭⣿⣿⡿⣷⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡜⣷⣿⣿⢿⡸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⢫⣿⣿⢿⣘⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⢆⡫⢾⣿⡿⣌⠳⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡷⣿⣿⣿⣯⢿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣾⣿⣿⣽⣿⣿⣿⣿⣿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡌⢖⡫⣿⣟⣇⠳⠼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣽⣿⣿⣿⢿⣾⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⢿⣾⣟⣿⣯⣿⣿⣿⣿⣯⢿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣻⣿⣿⣿⣟⡜⠥⣞⢽⣿⢼⡹⡸⢽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣿⣿⢽⣿⣿⣿⣻⣞⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣟⣿⣟⣿⣾⢿⣻⣿⣿⣿⣿⡯⣿⣿⣿⣿⣿⣿⣿⢾⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣟⣯⣷⣿⣿⣿⣿⣿⣻⢌⡳⣽⡞⣿⡇⣿⢥⡛⣼⣿⣿⣿⣿⣝⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣟⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣾⣻⢿⣿⣿⢼⣻⢿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣟⣾⢯⣿⢿⣻⣿⣿⣿⣿⣏⣷⣿⣿⣿⣿⣿⣻⢿⣿⡿⣽⣻⣿⣿⣿⣿⣿⣿⣿⢿⣻⣽⣾⣿⣿⡿⣟⣯⣿⣾⣿⣿⣽⠎⡖⣽⣿⡵⣿⠸⣷⣙⡖⣯⢿⣿⣿⣿⣿⣷⣮⣝⣻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⢿⣿⣿⣿⣯⣿⣿⣿⣟⣿⣿⣽⣯⢿⣿⣯⢯⣿⡞⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢾⣿⣽⣟⣾⡿⣯⣟⣿⣿⣿⣿⣿⣳⢞⣿⣿⣿⣿⣽⣿⣻⣿⢿⣽⣻⣿⣿⣿⢿⣻⣵⣾⣿⣻⡿⣽⡿⣾⣟⡿⣯⡷⣯⢿⣿⣻⣜⡱⣫⣿⣷⢻⡇⢿⣷⢺⣥⢻⣿⣿⣿⡿⣟⣿⣿⣿⣿⣶⣭⣛⡿⣿⣿⣿⣿⣿⣿⣯⢿⣿⣿⣿⣽⣾⣿⣿⣯⣿⣿⡷⣏⣿⣿⣯⣏⣿⢿⣻⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡯⣿⣿⢾⡯⣷⢿⣻⣽⢾⣿⣿⡿⣿⢧⣻⡽⣟⣿⣿⣻⣯⢷⣿⣻⢞⡷⣯⣿⣾⢿⣯⡷⣿⢾⣽⣻⣽⣻⢷⣯⣟⣷⣻⣽⣻⣿⣿⢆⡳⢽⣻⣿⣯⣝⠮⣿⣿⡜⣷⣹⣿⣿⣟⣿⢿⣽⣾⣿⢿⣿⣿⣿⣶⢯⣻⢿⣿⣿⣯⣟⣿⣿⣿⣻⣞⣿⣿⣳⣿⣿⣻⣏⣷⣿⣷⣻⢼⡿⣽⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡗⣿⣿⣻⡽⣽⣻⣽⣞⣿⢿⣳⣿⡿⣟⢶⣻⡿⣿⣿⣻⣿⣻⡾⣽⢾⣻⢷⣿⢯⣟⡾⣽⢯⣟⣾⣳⢯⣟⣻⢾⣹⠾⣵⣻⢼⣻⣿⢧⡹⢞⣿⣿⣿⣎⡷⣹⣿⣞⣽⣧⡟⣿⡾⣟⣯⣿⣻⣾⢿⣻⣾⢿⣽⣿⣿⣿⣾⣽⣿⡞⣿⣿⣿⡽⣯⣿⡿⣽⣿⣿⣽⣻⢼⣿⡷⣻⢾⣿⡯⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣹⣿⣿⣹⢿⡷⣏⣷⢿⣾⣿⢿⣹⡿⣏⡾⣱⣿⢿⣿⣹⣷⣿⣹⣏⢿⣹⣾⣹⡿⣾⣹⣏⡿⣾⣇⣿⣹⠾⡉⠏⡷⢿⣱⢏⡷⣏⣿⣇⠿⣉⣿⣿⣿⣿⢷⣹⣿⣿⡾⣿⣹⢷⡿⣏⡿⣾⣹⣏⣿⣿⣹⣿⣏⣿⣷⣿⣏⣿⣿⣹⣏⣿⣷⣿⣏⣿⣿⣹⣿⣿⡾⣿⢾⣿⣿⢹⢷⣿⢿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣻⣿⡿⣽⢾⣝⣻⡼⣟⡾⣽⣟⣯⣿⢧⣝⣳⢯⣿⣿⣽⣷⣻⣽⣞⡯⣷⢫⣿⣟⠷⠛⠈⠉⠀⠉⠀⠉⠈⠙⠋⢹⢣⠟⣾⡱⣏⠿⣞⡽⣣⢿⣿⣿⣿⣿⢾⣯⣿⣿⣟⡟⡎⠑⠉⠘⠁⠉⠈⠑⠋⠛⠳⠿⣯⣷⡿⣾⣿⣿⣷⣹⣿⣟⡷⣯⣿⣯⢿⣿⣿⣽⣻⢞⣽⣿⣏⣯⢿⣻⣽⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢯⣿⣿⡟⣾⡟⣾⣱⢿⣽⢺⣽⢾⣻⢾⣓⡮⣝⣯⣿⣷⣻⣾⣟⡷⣯⡗⡯⢿⠟⠀⠀⠀⠀⠀⠀⠀⠰⣶⣷⣶⠀⠀⠉⡞⣥⢻⣜⡻⣜⡳⣭⢿⣿⣿⣿⣾⣿⣿⣾⢿⡝⠀⢠⠀⠀⠀⠀⠀ ⠀⠀ ⠀⠀ ⣀⣀⡈⠙⠿⣽⣷⣿⣗⢯⣿⡿⣽⣳⣿⣽⢺⣿⡿⣾⡽⣞⣿⣏⣷⢯⢾⣹⣿⡿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⡿⣽⣹⡽⣹⣧⢟⡾⣝⡾⣯⣟⣯⠧⣟⡜⣷⣯⣿⣽⣳⢿⣽⡧⠟⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⣯⡔⠸⣼⣳⣾⣵⣯⣽⣣⣟⣿⣿⣿⣿⣿⣿⢯⡗⠌⣴⢧⠀⢀⠀⠀⠀⠀  ⠀⠀ ⠀⠛⠿⠃⡦⡀⠈⠟⡾⣽⣻⢾⣟⣷⣹⡿⣎⢿⣿⣻⢷⣻⡜⣿⣏⣿⡞⣯⢞⣿⣿⢿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡷⣿⣿⣻⣳⢿⡳⣿⣿⢫⣿⡜⡿⣵⡻⢾⣙⢮⣓⣟⡾⣿⣼⣟⣯⣷⡞⣅⠀⠼⢤⠠⠄⠀⢀⠀⢀⢀⡀⠀⠀⠀⢸⡟⣥⢻⡼⣷⡿⣿⣻⣿⡿⣿⣟⣯⣿⣾⣿⣿⢯⣞⡱⣬⢻⡄⠀⠈⢠⠀⠀⠀  ⠀⠀⠄⠀⢀⣿⡔⢀⣬⣑⡳⣝⣾⣟⡾⣱⣿⡍⣾⣿⢯⣟⡷⡭⣿⣯⣿⣯⢽⢾⣯⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⢽⣳⢯⣏⣷⣹⣿⡻⣞⡭⢿⣱⡟⣯⢞⣣⢯⣸⢿⣽⣞⣷⣻⣾⣿⡽⢀⠈⠻⢧⣀⣀⡄⣬⢤⣣⢦⢶⠶⣏⣿⣹⣞⣯⣟⣷⣿⣟⣿⣟⣿⣿⣿⢿⣿⡿⣿⣿⣿⣾⣟⣷⣯⣟⣷⡶⣦⣽⢧⣳⣌⣄⣀⣠⠎⣭⣀⢸⣿⣟⣿⣻⡼⣯⣗⣻⢧⡝⣶⣿⢿⡽⣞⡷⣹⣷⣿⣿⡞⣯⡷⣿⣻
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣳⣿⢞⣯⡟⡦⣽⢞⣿⡗⣯⡟⣭⢷⡻⡵⢎⣳⢳⡬⣟⣿⣞⣷⢯⣿⣿⣟⠤⢋⢾⣱⢻⡼⣹⢎⡷⣹⢎⣯⢻⡝⣶⢻⢮⡷⣻⣞⡷⣿⣽⣾⡿⣿⣾⣿⣟⣿⣿⡷⣿⣞⣯⢷⣻⣞⣷⣻⡽⣞⣯⢷⣻⠾⣽⣻⢞⣵⣯⢸⣿⡾⣟⣷⣻⡷⣹⣞⡏⣾⡱⣿⢯⡿⣽⣓⢿⡷⣿⣟⡯⣿⡗⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⢺⣷⢻⣱⣯⢯⣻⡯⣷⢯⡽⣞⡵⢯⣙⡮⢧⣓⢯⣿⡾⣿⣹⣿⣿⣿⡘⠬⣞⡵⣫⢞⡵⢫⢞⣥⢻⣬⢳⡝⣮⢏⣷⢻⡵⣯⢿⣽⣾⣻⣽⣿⣯⣷⣿⣟⣾⣿⣳⣟⡾⣯⢷⣻⡼⣳⡽⣳⢞⡯⣞⡻⢧⣟⡻⣞⣿⢸⣿⣿⣟⣿⣼⡻⡵⣾⣙⠶⣝⡿⣯⣟⡷⣏⣾⣟⣿⣿⢽⣿⣻⡽⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣞⣿⣻⡾⢧⣿⣿⢞⣭⢳⢯⣷⣹⢞⡽⣳⢸⡝⣧⡹⢎⣿⣿⣿⢧⣿⣿⣿⡇⢚⡵⣫⢗⡹⣎⢻⡜⢦⡳⢎⣧⠻⣼⡹⣎⠿⣼⢯⣟⣾⣳⢿⣻⣾⢿⣟⣾⣯⣿⣾⣳⢯⣟⣭⢷⡳⣽⢣⣟⡵⣫⠾⣵⢫⡟⣼⢳⣻⣿⣸⣿⣿⣯⣟⣶⡻⣵⡻⢜⡻⣼⣹⢷⣻⣽⢷⣺⣯⢿⣿⣺⣿⣳⣿⣻
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢾⣽⡧⣟⣻⣿⣿⣞⣮⠟⣞⣧⣛⣮⢷⡱⢮⣽⢲⢭⡓⣯⣷⣿⡧⣿⣿⣿⢧⢙⡾⣱⣋⠷⣜⣣⢞⣣⡝⡞⣴⡛⡶⣝⡞⣯⣳⢟⣾⣳⢿⣻⣯⣟⡃⣿⣯⣷⡿⣿⣽⣻⡼⣏⡾⣵⢫⡿⣼⢳⣭⢻⡜⣧⢻⡵⣫⢷⡯⣿⣿⣿⣯⣿⢶⡻⣼⣛⠼⣓⢧⡝⣿⡽⣯⡷⣯⣿⢻⣿⣽⣿⣳⡷⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣞⣷⢯⣿⣿⣿⣿⢺⣽⡹⣧⢻⡜⣧⠏⣾⢼⣋⢶⡙⢾⣿⣿⡗⣿⣿⣿⣏⠲⣝⢧⡝⣎⡳⣜⠧⣞⡼⣹⠖⣽⢳⡝⣾⣱⢯⣟⡾⣽⣻⣯⣷⣻⠰⣯⣷⡿⣽⣿⣳⢯⢷⣫⠷⣭⢷⣻⡷⣏⡞⣧⢻⡜⣧⢻⡵⣫⣟⣿⣿⣿⣿⣯⢷⣏⡷⣭⢚⡽⢮⡝⣷⢿⣯⡷⣟⣿⣹⢾⣿⣿⣹⣿⣽
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡝⣾⣻⣿⣿⣿⣿⡯⣗⣳⢯⡗⣯⢞⡵⣋⡾⣏⢮⢇⣻⢚⣿⣿⡟⣼⣿⣿⣿⠸⣝⢮⡜⣮⢳⣭⣛⢶⡹⣵⢫⣗⣯⡽⣞⣭⣟⡾⣽⡿⣽⣷⣿⣳⣟⣷⣿⣽⣟⣾⢯⣟⣯⢷⣛⣧⡟⣾⡽⢧⣻⠼⣧⣛⡞⣧⣻⣽⣎⣿⣿⣿⣿⣯⢷⣞⡳⣏⢧⣛⢧⡻⣼⣟⣯⡿⣽⣿⣽⣿⣿⣿⢳⣿⣯
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣽⣳⢟⣷⣻⣿⣿⣿⢾⡽⣹⢺⣇⢯⢺⡵⢩⣗⡟⣮⣙⠦⡏⣿⣿⣏⣿⣿⣿⣿⡙⣮⣓⢾⡱⣟⡶⢯⣳⠿⣼⣻⣼⡞⣷⣻⢾⣽⣻⣽⣟⡿⣷⣻⢿⣻⢿⡾⣟⣾⣻⣟⡾⣽⢾⡽⣶⣻⣳⣻⢻⣼⢻⡶⢯⣝⡾⣵⣻⢸⣿⣿⣿⣿⣯⠿⣼⢱⣏⡶⢏⡾⣱⠽⣾⣿⡿⣽⣿⣿⣾⣿⣭⡿⣞⣷
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣟⣶⣿⢯⡷⣯⢿⣟⡾⢯⢞⣽⣹⢜⡎⣿⡘⢧⣻⣼⢣⢞⡣⢇⣿⣿⣧⢿⣿⣾⣿⣧⢳⡽⣾⣽⣻⣞⡿⣽⣻⢷⣻⡾⣽⣷⣻⣿⢾⣟⣿⡾⡹⠥⠎⠦⣍⠎⡙⢻⣽⢿⣯⣿⢯⡿⣽⣳⢯⣗⣯⣟⡾⣯⣟⢿⣜⢷⣻⠥⣟⣿⣿⣿⣿⣯⢟⡧⢻⣜⢧⢻⡵⣫⠗⣿⣷⣟⣯⣿⣿⣾⣿⢧⣟⣷⢻
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣾⣿⣿⣿⣻⡝⣾⡿⣽⢫⣟⡮⡟⣼⡸⢧⣙⢧⡷⣞⢭⠚⣤⢓⢾⣿⣯⢿⣿⣿⣯⡷⢩⢾⣿⣞⡷⣯⣿⢷⣟⣯⣷⣿⢿⣾⣿⣽⣿⡿⣯⠗⠁⠀⠀⠀ ⠀⠄⠀⠀⢯⢿⣿⣾⢿⣻⣽⢯⣟⣾⣳⢯⣟⡷⣯⣟⢮⣟⡷⢨⣿⣿⣿⣿⣿⣯⡟⡼⣳⢺⣭⠳⣿⣱⢻⡜⣿⣯⣟⣿⣿⣷⣿⢺⣯⣟⢿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡾⣽⣿⣿⣿⣿⣳⣿⢻⡽⢯⣟⡾⣇⣟⢶⣛⠧⣎⡳⡝⣎⢇⡻⣔⢫⢾⣿⣯⣿⣿⣿⣿⣿⡈⢎⢿⣟⡾⣷⣻⢿⣻⣯⣿⣿⡿⣿⣾⣿⢿⡿⠁⠀⠀⠀⠀⠀⠀ ⡀⠀⠀⠘⡘⣿⣽⣿⣿⣻⣟⡿⣾⡽⣿⣽⣻⢗⣯⠳⠞⡱⢺⣿⣿⣿⣿⣿⣳⢟⡰⢧⣛⣧⢻⡽⣧⢳⣍⢿⣽⣯⣿⣿⣯⣿⢻⡾⣽⢾
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⣻⣼⢿⡽⣟⣯⣽⣺⢮⡿⡍⢞⡰⢵⡹⡜⢮⡱⢎⡳⣜⣿⡷⣿⣿⣿⣿⣿⡱⢊⡜⢻⡷⣹⡽⣻⣟⣿⣽⣿⣿⢿⣿⣾⣿⡏⡀⣠⣴⣤⡔⣀⡀⣤⣤⣄⠀⣇⢻⣿⣿⣾⢿⣽⣻⢷⣿⣻⠾⣝⠾⡌⢣⠜⣡⣿⣿⣿⣟⣿⣿⡽⣎⠵⣣⠞⣽⡎⣷⢯⡗⣮⢝⣿⣞⣯⣿⣿⣿⣹⢯⣟⡞
⣿⣿⣿⣿⣿⣿⣿⣿⣿⢷⣻⣿⣿⣿⢿⣯⣷⣿⡽⣯⢿⣻⢾⡵⠯⢏⣵⢺⣍⢾⡱⢧⣛⢶⡹⢮⡱⢎⣿⣟⣿⣿⣿⣟⣿⣇⠣⡜⡡⢟⡰⢏⢿⡾⣽⢾⣿⣾⢿⣟⣿⣾⠁⣿⣿⣿⣟⡾⡱⢟⡷⢊⠿⣷⣯⢾⣿⢷⡿⣯⣟⣯⣟⡾⢭⡛⡌⢣⠜⣡⠎⣥⣿⣿⣯⣿⢯⣿⢞⡬⢳⢥⢛⡲⣝⠮⣿⣽⣚⠮⣽⡾⣟⣿⣿⣯⢟⣟⡾⣝
⣿⣿⣿⣿⣿⣿⣿⣿⣏⣿⣿⢿⡽⣯⣿⣿⣿⣿⢿⣻⣯⢟⣫⣴⣿⣻⣼⢷⣞⣯⣽⣳⢯⡾⣝⣧⣛⠧⣿⣯⣿⣿⣿⣿⣺⣧⢛⡴⣉⢎⠲⣌⠣⠟⣭⢟⣿⣯⣟⡾⣿⣽⡘⣿⢿⣿⢿⡡⢓⡌⡖⣩⢂⠽⣟⢾⡽⣯⢟⡳⣿⡟⡼⠱⢋⠴⡘⡥⢚⠥⣚⢴⣿⣿⣳⢿⣻⣟⠮⣜⢣⢎⢧⠳⣬⠳⣝⡾⣭⢻⡜⣻⣟⣿⣿⣿⣻⢾⡽⣏
⣿⣿⣿⣿⣿⣿⣿⣿⣽⣻⣵⣿⣿⣿⣿⣿⡿⣿⣯⣛⣴⡿⣟⣷⣿⣿⣿⣿⣿⣯⣷⣿⣯⣿⣽⡾⣽⣳⣿⣷⣿⣿⣿⡿⣽⣿⡘⢶⡱⢪⡱⢈⡞⢤⡑⢎⢳⣯⢞⡽⣳⣽⡘⣧⣟⡿⢮⣑⠣⣜⣧⠒⣌⢚⡟⡜⡳⣍⠮⣵⢯⠛⡄⢣⡍⠖⣍⠲⣍⠺⡴⣹⣿⡿⣽⢯⡷⣟⠼⣌⠳⣎⢎⡳⣌⠻⣌⠷⣯⣇⠯⡵⣿⣽⣿⣿⣏⣿⢾⣹
⣿⣿⣿⣿⣿⣿⣿⣟⣾⣟⣳⣿⣿⣿⣿⣿⡿⣏⣶⡿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣷⣿⡿⣷⣻⣽⣿⣿⣿⣿⣳⣿⢜⣣⢍⡳⣌⠧⡘⢦⡙⢆⠣⢞⠯⡜⢳⢎⡳⢻⣽⣿⣳⢌⢣⠽⣾⡑⢆⣊⠧⣙⠲⣬⢳⣧⡟⡱⣘⢣⡜⢭⡸⡱⢎⡳⣱⢹⣿⣿⢯⣟⡷⣏⠞⣬⢓⣎⢮⡱⢎⡽⢬⣳⢣⣟⣮⡵⣹⢾⣿⣿⣿⣞⣻⡼
⣿⣿⣿⣿⣿⣟⣷⣿⢿⣼⣿⣿⣿⣿⣿⡿⣱⣿⣻⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣽⣻⣿⣿⣿⡷⣗⣿⢎⡾⣌⠳⣌⡳⢥⠒⡍⢎⡱⢎⠲⣉⠣⢎⡱⡹⣿⣿⣿⣎⡜⡜⢶⣍⠲⣌⡗⣈⠖⡹⢿⠳⡏⢴⠱⣊⡜⢦⡓⡝⢮⡱⢣⢻⣿⣿⣻⠾⣝⡮⣙⢦⢫⡜⣶⡹⣝⣾⣳⣽⣻⣞⣷⡿⣶⡻⣿⣿⣿⡯⣗⣻
⣿⣿⣿⣿⢿⣿⣿⢫⣿⣿⣿⣿⣿⣿⣳⡿⣯⢷⣿⣻⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⡷⣿⣽⣿⣿⣿⣻⣏⣿⢎⡷⢪⡝⣲⠝⣎⢧⢹⡘⡴⢋⡕⢪⡱⢆⠦⣑⠹⣿⣿⠆⠳⣌⢻⣜⠢⡝⡏⣔⢫⡱⢎⡽⣘⠎⡵⢣⠞⣥⡛⣜⣣⢝⡣⢿⣟⣿⣳⢿⣹⢶⣙⢮⣳⣽⣾⣽⣿⣿⣿⣿⣿⣿⣿⣿⢿⣽⣻⢿⣿⣿⣽⣳
⣿⣿⣿⣽⣿⡟⣎⣿⣿⣿⣿⣿⣿⣿⣏⡷⣯⣿⣾⢿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⡿⣿⣿⣿⡟⣧⣿⣿⣿⣯⣷⢏⣿⢎⣞⣳⡜⣱⣛⢮⡳⢦⡙⢶⡩⡜⡱⡜⢬⢲⣉⠞⣿⡟⡌⢃⠆⣿⡎⡴⠳⡜⡜⢦⡙⢮⡳⣌⡻⣜⢯⡝⣶⡹⢮⠵⣎⢳⣹⣿⣹⣯⢷⣫⢞⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣳⣯⢿⣿⣿⣗⣯
⣿⣿⣿⣿⡟⣹⣧⣿⣿⣿⣿⣿⢷⣿⡧⣿⣳⢿⣯⣿⣟⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⡯⣽⣿⣿⣳⣟⡾⣡⣿⢎⡼⣿⢷⢣⢭⡳⣏⣷⣙⣎⢷⣭⡱⢎⡣⢇⡞⠼⣱⣋⡜⢦⣛⡯⢗⣝⣣⠝⣎⡳⣍⡟⣴⢫⢷⣹⢮⣝⡶⣝⢯⡓⣎⠳⣞⣯⡟⣿⣯⢞⡇⣿⣿⣿⣿⣿⣯⣿⣟⣿⣽⣿⣿⣿⣿⢿⣳⣯⣟⣎⣿⣿⣾
⣿⣿⣿⡽⣼⣿⢲⣿⣿⣿⣿⣿⣿⣿⡗⣯⣟⣯⢿⣾⢿⣻⣿⣾⣿⣻⣿⣽⣿⣿⣿⣿⣿⣟⣿⣿⢿⢧⣿⣿⣳⢟⣾⡃⢷⣟⠆⣿⡽⣏⣞⢦⡓⣝⢺⣗⣮⣛⣾⣳⡭⢞⡱⢮⡹⣱⢧⢺⡱⣎⠿⣜⡞⣬⢻⡜⢧⣿⣝⣮⢟⣞⣧⡟⣮⢳⡝⢎⣱⣎⣿⡾⣽⣻⡽⣿⢮⡽⢺⣿⣿⣿⣿⣿⡷⣿⣟⣿⣾⣿⣿⡿⣟⣿⢾⡽⣾⣹⣿⣿
⣿⡿⣾⢱⣿⣿⣹⣿⣿⣿⡿⣾⣿⣿⣛⢷⡽⣞⣿⣽⣿⣿⣿⣳⣿⣻⣿⣽⣿⣿⣿⣿⣽⣿⣿⣿⣿⣺⣿⢷⣛⡾⣧⠙⣾⢿⡘⣼⢿⣽⣞⣯⢷⣎⣧⡜⠮⣟⣾⢿⣿⣭⣛⢶⡹⣭⣏⢷⡳⣭⢟⡼⣝⣮⢳⣏⣿⣾⡽⣞⡿⣚⡾⣹⢣⣳⣼⣯⣷⣿⣿⡇⣿⣳⡽⣻⣿⢼⡹⣿⣿⣿⣿⣾⣿⣽⣻⢾⣻⣿⣿⣿⣿⣟⣯⣟⢾⣽⣿⣿
⣿⣻⢧⣿⣿⡿⣼⣿⣯⣿⣿⣿⣿⡷⡽⣎⣽⣻⢾⣽⣾⣿⣟⣷⣏⢷⣟⣿⣾⢿⣟⣿⣿⣻⣾⢿⣲⣿⢯⢯⣗⡿⢢⢋⣿⢯⡒⣽⣻⣟⣾⣽⢻⣞⣷⣿⣷⣬⣝⣻⢿⣿⣟⣮⢷⡽⣮⣳⡽⢮⣟⡾⣽⣚⣯⣾⣿⣷⢿⣯⠟⣍⣣⣷⣿⣿⣿⣻⣿⣿⣟⡧⢹⡗⣯⢻⣿⣧⢇⣻⣿⣯⣷⣿⣻⢾⣽⣻⣿⢿⣿⣷⣿⣻⣞⡾⣏⢾⣿⣿
⣿⣏⣾⣿⣿⡟⣷⣿⣟⣯⣿⣿⣿⢳⣽⡳⡜⣯⢿⣽⣷⣿⣿⣿⡜⢮⡽⣾⡽⣟⣯⡿⣞⡿⣽⢯⣿⣏⡟⣾⢺⡍⣇⣻⣟⠮⣱⢺⣷⣛⣾⡝⣯⠾⣽⢯⣿⣿⣿⣷⣯⣜⡻⢯⣟⣾⢷⣳⣟⡿⣾⣽⣳⣟⣾⢿⣳⠟⣫⣴⣻⣿⣿⣿⣟⣿⣿⣷⣿⣿⣻⡝⢦⢻⡽⣣⢿⣿⣏⡖⣻⣿⣽⣷⣻⢟⡾⣽⡿⣿⣿⢿⣾⢷⣯⣳⠏⣿⣿⣿
⣿⢼⣿⣿⣿⣏⡷⣿⣿⣿⣿⣿⣟⢳⢮⣟⡵⡸⢿⣽⡾⣟⣯⣿⡿⡌⣞⣳⢽⣛⠾⣝⡯⣟⣵⣿⡻⣼⣹⢞⡯⢜⣰⣿⢺⢱⢣⣟⣾⣳⣭⢿⡾⣹⢎⡿⣽⣾⢿⣻⣿⣿⣿⣿⣼⣻⢯⣷⢯⣟⣷⣯⡷⣿⢛⣫⣴⣿⣿⣿⣿⡿⣿⣟⣿⣻⣞⡿⣽⡷⣟⡿⣌⢳⡻⣽⡚⣿⣿⣷⣙⡾⣷⢯⡝⣾⣟⣿⣿⣿⣿⣿⣯⣟⣾⡱⢻⣧⢿⣿
⣟⣾⣿⣿⣿⣧⣿⣿⢯⣿⣿⣿⣏⡟⣮⡟⡖⣧⠹⣞⣿⣻⣟⣯⣿⡕⡸⢧⡻⣜⢯⡳⣝⣾⣻⠶⣝⣧⣛⢮⠕⣮⣟⢧⣋⠞⣼⣻⣞⡷⣯⢷⣏⣷⣫⣞⣷⣻⢿⣟⣿⢿⣿⣿⢿⣿⣿⣾⣿⣻⣿⣾⣿⣳⣿⣿⣿⣿⣿⡿⣟⣿⣟⣯⣷⢻⣜⡿⣯⢷⣯⢿⡽⣶⣹⢳⡟⡼⣿⣿⣮⣝⡳⣏⠞⣽⣾⣿⣿⣿⡿⣿⣳⣟⡶⣉⣿⡽⣾⣿
⣿⣿⣯⣿⣿⣧⣿⣾⣿⣿⣿⣿⡧⣟⡼⣏⡗⣯⢳⣘⡳⢯⡿⣽⢾⣽⡐⣯⢳⢎⡳⣳⡽⣯⢗⣻⡝⡶⢩⡞⣾⣻⢎⡳⣌⣻⣞⣷⣻⢾⣽⣻⣞⣷⣻⣞⡷⣯⣟⣾⡽⣯⣟⣿⡿⣯⣿⣾⣿⣿⣷⣿⣿⣿⣿⣿⣿⢯⣿⣿⡿⣿⣻⡽⣞⡿⣾⡽⣯⢷⣯⢷⣻⡵⣯⣳⣝⣳⡹⣿⣿⣮⡕⣎⢺⡽⣿⣿⣿⡿⣿⣿⡽⣞⢱⢾⣹⢿⡽⣿
⣿⣷⡿⣿⣾⣷⣻⣿⣿⣿⣿⣿⣱⣏⣿⣏⡿⣜⢧⣧⡙⢯⠽⣹⣛⣮⢳⣭⣿⢨⣳⣯⡟⣵⣫⢷⡹⣡⢻⣽⢳⠝⣪⢵⣞⣷⣻⣾⣽⡿⣞⣷⣻⣞⡷⣯⣟⡷⣛⡾⣽⣳⢾⣽⣻⣷⣻⣿⣽⣿⣿⣿⣿⣿⣻⢾⡽⣿⢿⣯⢟⡷⣯⣟⣯⣟⣷⢿⣽⣻⣞⣯⢷⣻⡵⣏⡾⣥⣳⠹⣾⣟⣷⡘⣼⣹⢿⣽⣷⡿⣟⣷⡛⡴⣟⢺⡽⣯⡗⣿
⣿⣯⣿⣟⣷⣯⢿⣿⣿⣿⣿⣿⢼⡧⣿⢯⡷⣹⢎⣷⣻⡡⣏⢧⡹⣜⠳⡜⢣⣾⡟⣶⢻⡜⣧⠫⣴⠳⡟⣬⢧⣟⣷⣻⣾⣿⣿⣿⣿⢿⣟⣯⣿⣽⣻⢷⣯⢿⡽⣻⡵⢯⣟⣾⣷⣧⣟⣾⣳⣛⣞⣳⢯⡗⣯⢷⣻⣽⣻⣞⣯⣟⡷⣯⣟⣾⣯⢿⡾⣷⣻⣞⣯⢷⣛⡾⣵⢫⡖⣯⢜⣻⣞⣧⢺⡵⣻⣟⡾⣽⣻⠦⣹⠵⣏⡳⣽⢷⡏⣿
⣿⣯⣷⣿⣻⣽⣻⣿⣿⣿⣿⡿⣾⡽⣿⣻⣝⢧⡻⣞⣷⣳⡙⣦⠳⣜⡹⢆⡿⢧⣟⡞⣧⢛⡴⢫⡵⣻⡼⣯⣟⡾⣷⣿⣳⣿⣿⣿⢿⣿⣿⣿⣽⣷⣿⣻⣞⣯⢿⣵⣫⢟⡾⣜⡷⣻⣿⣿⡿⣝⣮⡝⣮⢿⣽⣻⢗⣯⢶⣻⢾⣽⣻⣽⣯⢿⣾⣟⣿⣟⣷⣯⣟⣯⢿⡽⣞⡯⣽⣚⢮⡒⢿⣾⡱⢣⡟⣾⠹⣧⢇⣯⢱⡻⣇⢽⣚⣯⣏⣿
⣿⣽⣾⢿⣽⣿⣹⣿⣿⣿⣿⣟⣷⣻⣽⢿⣏⡶⣻⡽⣞⡷⣧⢻⡱⢎⡵⣻⢏⡿⠼⣙⡤⢯⡜⣷⣛⢷⣻⣳⢯⣿⣟⣾⣿⣿⣷⣿⣿⣿⣿⣿⣿⣾⣟⣷⣻⣞⢿⣮⣏⣟⠾⣝⢾⡳⢯⣿⣿⣟⣾⣽⣯⢟⡾⣭⣟⢾⣯⣟⡿⣞⣿⣳⣿⣿⣻⣾⣿⣯⣿⣾⣻⣾⢯⣟⣷⣫⣗⢯⣳⠽⣎⠷⣏⢷⡼⣡⠟⣼⢏⣖⣫⡽⣸⡚⢦⡿⣧⣿
⣿⣻⣾⣟⣷⢿⣳⣿⣿⣿⣿⣟⡾⣯⢿⣻⣧⢷⣹⡽⣯⣟⡷⣎⡝⢮⡼⠯⣏⠵⣛⣬⢛⣧⣛⡶⢯⣛⡷⣯⢿⣳⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣟⣷⢯⣟⣶⡻⣞⢯⣛⡮⣝⢯⡞⣿⢿⣿⡻⣼⢯⡽⢶⢯⣟⣶⢯⣿⣻⣟⣿⣽⣾⣿⣿⣽⣿⣿⣷⡿⣯⣿⣞⡷⣽⣞⣻⣼⢻⡼⣹⢻⣎⣧⢳⡹⣎⢯⡲⢵⣋⠧⣝⣣⢿⡷⣿
⣿⢯⣷⣟⣯⡿⣷⣻⣿⣿⣿⣯⣟⣿⣽⣻⣽⢧⣛⣾⣳⢯⣟⡷⣜⣣⣟⢃⡾⣍⢳⠬⣏⢶⡹⣞⢯⣟⡽⣯⣟⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣯⣿⣞⡷⣻⢽⣚⣧⢻⡜⣧⢻⡼⣻⢾⣱⢟⣮⠽⣏⡿⣾⡽⣯⣷⡿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣾⣿⣟⣷⣯⣟⡷⣯⢷⣫⣟⢾⣧⢻⣎⠷⣣⢗⡯⣲⠝⣯⢼⡙⡦⢏⣿⣏⣿
⣿⣟⣷⣯⢿⣽⣷⣻⣿⣿⣿⡷⣯⣿⡼⣷⡿⣯⡜⡷⣯⣛⡾⡙⡍⣾⡽⢸⠲⣍⢮⢳⢎⡷⣫⡽⣳⢞⡽⣷⣻⣾⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣯⣷⢯⣟⣭⢷⣫⢞⣧⢻⡜⣧⡹⣽⢇⣾⡹⢮⢿⣝⣿⣳⣟⡿⣷⣿⣿⣿⣿⣾⣿⣿⣿⣿⣽⣿⣯⣿⣿⣾⣽⣻⡽⣯⣳⢯⣟⣾⢣⢿⣃⢷⡏⣞⡥⣛⢧⡗⣭⡓⣏⣾⣏⣿
⣿⢾⣳⣯⣿⣞⡷⣯⣿⣿⣿⣟⣽⡿⣽⣳⣿⣻⠼⣹⠓⡭⢰⡱⣘⣷⣻⢸⢏⡜⣎⢧⡻⣜⢧⣻⢵⣻⡽⣯⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣷⢿⣻⢾⣝⡾⣱⢯⡞⣧⢻⣔⡳⣍⢺⡵⣫⢟⡽⣞⣷⣻⣾⢿⣿⣻⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣷⡿⣯⣷⣻⣗⣯⢿⣞⡷⣏⢾⡹⡞⡵⢮⢵⢫⡾⢱⡲⡹⣜⣾⣽⣻
⣿⢯⣟⣾⣳⣯⢿⣞⣿⣿⣿⣻⣞⡿⣷⢻⣾⢯⠛⡤⢛⠴⣃⠖⣱⣯⢷⡹⢎⡼⢎⡳⣝⢮⣻⡜⣯⢷⣻⢷⣻⣾⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣽⣟⣯⣟⣮⢗⡯⣞⡵⣫⢗⢮⠵⡎⣾⣱⢯⢯⣟⡽⣞⣷⡿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣟⣷⣻⢮⣟⡾⢯⣟⣞⠮⣗⠯⡵⣋⢮⢷⢏⢧⢳⡙⣦⣟⣾⢿
⡿⣯⣟⣾⣳⢯⡿⣼⣿⣯⣿⢷⣫⣿⢯⡟⢩⢖⡹⢌⠳⡸⢄⠏⣼⢯⣯⢳⡹⣜⣫⢵⢫⡞⣵⢫⣯⢟⡽⣯⢿⣳⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣷⣿⣽⡾⣽⢾⣽⣚⢷⡹⣞⡵⣫⢞⡹⢶⣏⢾⣹⠾⣭⢿⣽⡾⣟⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⡿⣞⣯⣟⡾⣽⣻⡽⣾⣙⣧⠻⣜⠭⣞⡯⡜⣎⢧⣙⢦⣿⢾⣿
⣿⣳⣟⡾⣽⢯⣟⡾⣷⣟⣯⣿⡽⣞⢋⡜⢣⢞⡸⢌⡣⢕⡪⡑⣯⣟⣾⢳⣙⢦⢳⣎⢷⡹⣞⡽⢮⡿⣽⣻⣟⡿⣽⣾⣿⣻⣿⣿⣿⣿⣿⣿⣿⣽⡿⣾⢷⣟⣯⣟⡶⣏⣯⡳⣝⡞⣵⢫⡝⣎⢞⡧⢯⣟⣽⣻⢾⣽⢿⣯⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⡿⣟⣿⣳⣯⣟⣧⢿⡽⣶⣓⣎⢳⡍⣾⡽⣱⢚⡜⢦⡙⣮⢿⣯⡿
⣷⢿⣾⣹⣏⡿⣾⢷⣏⡿⣏⣷⠏⣰⠏⡸⢇⡾⡰⢏⡸⢎⢱⢱⡿⣾⢷⢹⣎⢹⡶⣎⢷⡹⣎⡹⣷⢏⣷⢿⣾⣹⣿⣹⡿⣿⣿⢿⣹⣿⣿⡿⣾⣿⣹⡿⣿⡾⣷⣏⣹⡏⣶⢿⣈⢿⡸⣇⡾⣈⡏⣾⢹⡾⣾⣹⢿⡾⣿⣹⣾⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣹⣷⢿⣾⣹⢾⣹⢷⣇⡎⢷⡸⣷⢁⡇⣏⡸⢇⡹⣸⡿⣾⠷
⣯⣟⣾⢳⣯⣻⡽⣎⣿⣻⡽⢣⠞⣥⢫⡕⣣⠖⡝⢮⡱⣋⢮⡱⣻⣭⢿⡌⣟⢦⣛⣬⠳⣝⢮⡳⣽⢺⡽⣞⣳⣟⡾⣽⣟⣿⣽⡿⣿⣯⣷⡿⣟⡷⣿⣽⣳⣟⡷⣽⣣⢟⡭⣗⢫⢎⡷⡹⢎⢷⣚⢧⡟⡾⣵⢫⡾⣽⢷⡿⣽⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣟⣷⡿⣽⣻⢾⡽⣞⣯⣟⡮⡜⢢⡹⠇⡜⡰⢡⢛⡬⢳⣱⢿⣏⢳
⣷⣻⡞⣟⡾⣵⣻⡽⣞⠷⣡⢏⡞⡴⢣⡞⣥⡛⣼⢣⢳⡍⣶⠱⣟⡾⣻⢤⢻⡮⡕⣎⢳⡝⣮⢳⡭⣗⢯⣽⢳⣯⢿⡽⣾⡽⣞⣿⡽⣷⢯⣟⣯⣟⣳⢯⣷⢻⣞⢧⡟⣮⢗⣮⢛⡞⣶⢹⡹⢆⣛⢮⣝⣳⡭⣷⣻⡽⣯⢿⣟⣾⣿⣿⣾⣿⣽⣿⢿⣿⢿⣻⣷⣿⢯⣿⢯⡿⣽⢯⣟⠾⣽⣞⣳⠇⣍⠳⣔⢣⠘⡔⠣⡜⢨⢇⣿⡿⣌⠧
⡷⣯⡽⣯⣽⡳⣏⢷⢋⠶⡱⢮⡜⡵⢫⡜⡶⣹⣒⢯⣓⢾⣡⠟⣽⣷⣻⢎⡜⣷⡹⣬⡓⡾⣱⢏⡾⣹⢞⡮⣟⡼⢯⣽⣳⢿⣽⣳⡿⣽⣻⣞⢷⣫⡽⣏⣾⢻⣼⢫⣞⡵⣫⢞⡹⡞⣥⠯⣽⢸⣹⢺⡜⣧⢻⣼⣳⠿⣽⢯⣟⡿⣾⣷⢿⣯⣿⣻⣿⣻⡿⣟⣿⡾⣟⣯⡿⣽⢯⣟⣞⣻⢳⡯⣽⡘⡴⢩⢆⣋⢖⡨⠱⠌⡥⢾⣯⠳⣌⢳
⣟⡷⣻⣵⡳⣿⣹⠎⡸⣇⣛⢦⡝⣞⣣⢟⡱⢧⣏⠾⣭⠶⣭⢻⡼⣿⣯⡇⢾⡰⣟⣦⢹⡱⢧⣛⡼⢣⡟⣼⣭⢻⡽⣲⢟⣮⢗⣯⢿⣳⢟⣞⣯⢳⣝⢮⡗⣯⢞⡳⣎⢷⡹⢎⡷⣹⡒⣟⠆⣸⢎⡷⣹⢎⡟⡶⣝⣻⣽⣻⣞⣿⣳⢿⣯⢷⣟⡷⣯⣷⡿⣟⣯⣿⣻⢷⣻⣽⣛⡾⣎⠷⣯⢽⠆⣧⠓⡭⢎⡼⢌⡣⢇⠹⣼⢿⡙⢢⢍⠲
⣯⣽⣳⡳⣟⣵⠫⣰⢇⡯⣜⡞⣼⡱⣎⢯⣝⡳⣎⠿⣜⣻⡼⢧⣳⢻⣿⣽⢪⣵⠸⣧⢧⡹⢖⣣⡝⣧⣛⠶⣭⢳⡝⣧⡻⣜⢯⡞⣧⢟⡾⣹⢎⡷⢮⣳⢻⡜⣯⢳⡝⣮⡝⣪⢵⢣⣻⠼⡱⢌⡻⣴⢫⡞⣽⢳⣝⣳⢮⣗⣻⢾⣽⣻⣞⠿⣾⣽⣳⢯⣟⡿⣽⢾⣽⣫⢷⣏⢷⡻⣼⢻⣜⡏⡞⡴⢫⡜⣣⢎⢧⡹⣌⢳⢫⡟⠨⣅⠪⣱
⣷⡳⣽⢽⣹⡞⢡⡳⢎⡷⣚⡼⣥⢻⣜⡳⣎⣷⡹⣏⣯⠷⣽⣫⢷⡭⣿⣟⡦⢯⣛⡬⢷⡙⢮⡱⢞⡱⣎⡻⣜⢧⣛⢶⡹⣝⢮⡝⣮⢻⡜⣧⢯⡝⣧⢏⡷⣹⢎⡷⡹⢦⡝⢦⣛⢮⢇⢣⡱⢎⡱⢧⣛⡼⢣⡟⣼⢣⠿⣜⣯⣞⠷⣧⣻⣛⢷⣺⡽⣻⢾⡽⣏⣿⢲⢯⣳⢞⣯⢳⣭⢳⡞⡸⡵⢭⣓⢮⡕⢮⡲⡕⣎⢧⠳⡌⡱⢄⡓⣼
⣿⡽⣞⢯⣳⠍⣳⢭⣛⡼⣣⠷⣭⢳⡞⣽⢳⣎⣿⣹⢞⣻⣳⡽⣯⢾⡱⣿⡷⣹⣭⢟⣦⢻⡆⢏⡳⣹⡜⡵⣫⠞⣭⠞⣵⢫⡞⡽⢎⡷⣹⢎⡷⣹⢮⡝⢶⣹⠺⣜⡝⣮⢹⢧⡏⢏⡜⢦⢣⢏⡜⢳⢧⣚⠧⣝⠮⣝⡿⣹⠶⣭⢟⣞⡳⢯⣛⣶⢻⡭⢷⣫⢗⡞⣯⢳⡝⡾⣜⡳⢮⠟⣴⢯⡝⣧⢏⡶⣹⢣⡗⣹⠜⣎⣳⢱⡂⠎⢴⣻
⠿⣿⡭⣷⢫⣘⢧⣏⢞⡶⣭⢻⣜⢷⣫⢯⡷⣛⡶⣯⣟⡷⣯⣟⡷⣯⣗⢯⣷⣣⢻⡾⣭⢷⣫⢧⡑⢧⣚⡵⡹⡞⣥⠻⣜⢧⣛⡼⢫⡜⣧⢻⡜⢧⡻⡜⣧⢓⡻⡜⣼⢡⡟⣾⡘⢮⢜⡣⢇⡞⡼⣈⠳⣭⠞⣥⣛⣮⢳⣭⠻⡜⢾⡼⣹⢏⡾⣍⢷⡹⣏⢾⡹⣞⡵⣫⢞⡵⢫⡽⢋⣾⣳⣞⢾⣱⢯⡞⣵⢫⡞⣥⢻⡜⢦⡳⢭⡜⢲⡿
⣟⠽⣷⣫⠇⣞⢧⡞⣽⢺⡵⣛⣮⢟⡼⣯⡽⣯⣟⡷⣯⣟⡷⣯⣟⣷⣻⣶⢫⣗⢯⣻⣽⣳⢯⠾⣝⡎⠳⣼⢱⡏⣖⠻⡜⣎⢶⡙⣧⢻⡴⣋⢾⡹⢧⡝⣲⢫⠵⡹⢆⠣⣜⢣⡜⢣⢮⢱⣃⢮⡱⢎⡱⢌⠻⣖⡿⣼⢳⢮⣟⠼⣓⠾⣱⢏⡾⣙⢮⠵⣏⢾⡱⣎⠷⣙⢮⡝⣫⡴⣟⣾⣳⣞⣯⠷⣏⡾⣭⢷⡹⣎⢷⡚⡧⡝⣦⠹⣌⠷
⣏⢯⡽⣿⣘⢮⡳⣝⢮⣳⠽⣝⣮⠿⣽⣳⣟⡷⣯⣟⣷⣯⢿⣷⣻⣾⣽⣞⣯⡞⡗⣮⠷⣯⣟⣻⢧⣏⡗⡤⣋⠼⣎⢳⡹⣜⢲⡙⡶⣻⢶⡹⢎⣝⢣⠞⣥⠋⣎⢱⡊⡵⢊⡖⣩⢓⢎⡆⢳⢢⡝⢬⡱⢎⠖⣸⣿⣯⣿⣻⣮⠹⡼⣩⠗⣎⡳⡝⣮⢳⡜⢣⣟⡼⣣⠟⣬⣞⣵⣫⣿⣳⣟⣾⣽⣻⡽⣯⢷⣫⠷⣝⡮⣽⡱⣛⡴⣛⠼⣆
⣻⢎⡷⣃⢯⡞⣵⢫⡾⣱⠿⣽⣺⢟⣷⣻⢾⣽⣳⡿⣾⣽⡿⣞⣿⢾⣳⡿⣯⢿⡽⣎⣻⢳⣯⡽⣞⣮⡝⡶⣩⠞⡹⢆⡱⢌⢢⡙⢲⢹⠧⡙⠎⡜⠤⢣⡔⣩⢆⡳⢜⡡⢏⡜⡱⢎⢲⡽⣎⠶⢮⡱⣘⢎⡝⣆⠻⢿⡻⠟⢢⢛⡴⢋⡞⣥⢳⣙⣾⢣⠝⠣⠜⢳⣟⣾⡟⣞⣶⢿⣳⣯⣿⣞⣷⣯⢿⡽⣯⢯⣿⣹⢞⡵⣫⢵⡳⡭⣞⡹
⢯⡞⣵⣸⢳⡞⣵⣫⢗⣯⢟⣳⢯⣟⡾⣽⣻⣞⣯⣿⣟⣷⣿⣿⣻⣿⣟⣿⣿⣻⣟⣾⡱⣏⡾⣽⣳⢧⡟⣵⢣⢏⡵⢋⡖⢣⢆⢧⠣⡜⢢⡉⢼⡓⣎⠳⣜⡱⢎⡵⢪⡕⣫⠜⡵⢫⡞⡽⣸⡙⡮⣕⢫⠞⡼⣌⡛⢦⠳⣍⠧⢦⢌⡱⠌⡔⢣⠜⡎⡔⢊⡱⣎⢷⣿⢳⡽⣾⣟⣿⡿⣽⣾⢿⣽⣾⣿⣻⣽⣻⢾⣭⣟⡾⣵⣫⢷⡹⣖⡹
⣻⢼⢣⡳⣝⢾⡱⢯⡾⣭⢿⣽⣻⢾⣽⣻⡷⣟⣯⣷⣿⢿⣷⡿⣿⣽⡿⣿⣾⢿⣽⡷⣿⣭⣳⣏⠷⣯⣛⣮⢳⣎⡜⣣⢞⡱⢎⠮⡱⣌⠧⡜⢦⡹⣌⢳⣌⠳⣍⢞⡱⢎⡵⢫⠵⣫⢳⡱⢣⣝⠲⡝⢮⣙⠶⣡⢛⡬⣓⢎⡟⣬⢚⡴⢋⡜⣆⠩⢔⢢⢏⡵⣽⢟⣼⣳⣿⣟⣿⣽⣿⣟⣿⣿⢿⣷⣿⣻⣯⡿⣟⣾⡽⣞⣷⣹⣎⠷⣭⢳
⣧⢻⢸⡳⣝⢮⡽⣳⣏⣯⣟⡾⣽⣻⢾⡷⣿⣿⣻⣯⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⡿⣽⡿⣞⣷⣞⠿⣧⣻⢼⡳⢮⡜⡱⢎⡵⣊⠷⣑⠮⣱⡙⢦⠳⣌⡳⣌⠗⣎⠮⣕⢫⣜⢣⡛⡴⢣⡝⣣⠮⣝⡹⢦⡙⢮⡱⣋⠶⣩⢎⡷⣌⠳⣜⢣⠞⡬⠹⣌⡷⣫⡽⣣⣿⢾⣻⣽⣾⢿⣻⣾⣿⣿⣿⣿⣿⣷⣿⡿⣽⣿⡷⣿⡽⣞⡷⣞⣻⣜⣳
⣞⠭⣏⢷⡹⣎⡷⣻⣼⢳⣯⣟⡷⣿⣻⣟⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⡿⣿⡿⣽⣟⡾⣽⣻⢧⡟⣮⢽⣣⢏⡵⣋⠶⣩⠞⣌⢧⡱⢎⢣⡛⠴⣓⢬⡛⣬⢓⣎⠳⣬⢣⡝⡖⣭⢚⡥⣛⠴⣙⢦⣋⢧⢓⡭⣚⢥⣺⠵⣌⠳⣌⢣⠞⣰⣛⡬⢷⣭⢷⡿⣽⣻⣯⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⢯⣿⣽⣻⡽⣖⢯⢶
⡞⣝⢯⡞⡵⣏⣾⢳⣭⣟⡾⣽⣻⢷⡿⣯⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣟⣾⣟⡷⣯⢟⣾⡹⣎⢷⣋⠶⣩⠞⣥⢛⡬⢲⢱⡊⣕⢪⠓⡭⢲⡙⡴⣋⡜⡳⣌⠳⣜⣣⠜⣣⠞⣡⢛⡜⣆⡓⣎⢣⠞⣡⠞⣜⠣⣌⠳⣌⠳⢎⡵⣣⢟⡽⣮⢿⣽⣳⣟⣷⢿⣻⣯⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣻⣞⣷⣻⡽⣞⢯
⣽⢸⢧⡻⣝⠾⣼⣛⣮⢿⣽⣳⢿⣻⣿⢿⣽⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⢿⣾⣻⢾⡽⣯⢟⣶⢻⡝⣮⢭⡳⢥⡛⡴⣋⡜⣣⠇⡞⢤⢣⡙⣌⠓⠬⠱⠜⡲⣑⢎⠳⡌⣷⡩⢆⡝⣢⢃⡞⣤⠳⡜⠦⢛⢠⠻⣝⠲⣌⠳⣌⢻⣜⡳⣝⢾⡹⣧⣟⢾⣳⣟⡾⣿⣻⣽⣿⣻⣽⣿⣿⣿⣿⣿⣿⣿⣿⣯⣷⣿⢿⣽⣾⣳⢿⣹⣞
⣞⢸⢧⡻⣜⣻⡵⣻⣞⢿⡾⣽⣻⣯⣿⢿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⢯⣟⣯⢿⣝⣻⡼⣳⢻⡜⣧⣛⢦⡙⢶⡱⢎⡕⡫⢜⠣⠖⡉⣄⠚⠬⣑⠲⡐⠤⡊⢍⡩⡙⡍⣋⠜⡩⢍⡩⠔⠣⠜⣐⠣⢢⠱⢠⠒⡌⠱⢎⡳⢎⡷⣹⢎⡷⣳⢞⣯⢷⣯⢿⡽⣟⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣻⡾⣽⢯⡷⣞
--]===========================================================]

local VERSION = "2.0.0"

local CFG = {
	o       = "zurai02",
	r       = "zurai-hub",
	b       = "main",
	f       = "Scr/games",
	rt      = 5,
	rd      = 1.0,
	dbg     = false,
	webhook = "https://discord.com/api/webhooks/1552313779373736027/5nd4D4qo3BiQ8ERz-VQTJ4BH_6AGnX1uxJzcSycsyOYyiB0JTkgrxesfnG6jlfo4rnEB",
}

local HS  = game:GetService("HttpService")
local PLR = game:GetService("Players")
local TW  = game:GetService("TweenService")

local CFG_KEY = "zurai_hub_config.json"
local EXTS    = table.freeze({ ".luau", ".lua" })
local CACHE   = {} :: { [string]: string }
local BOT_AVA = "https://raw.githubusercontent.com/zurai02/zurai-hub/main/zurai_hub_roblox_icon.png"
local ICHIGO  = "https://raw.githubusercontent.com/zurai02/zurai-hub/main/ichigo-kurosaki-1920x1080-27105.png"

local RAW  = ("https://raw.githubusercontent.com/%s/%s/%s/"):format(CFG.o, CFG.r, CFG.b)
local BASE = RAW .. CFG.f .. "/"

local fmt     = string.format
local find    = string.find
local pairs   = pairs
local pcall   = pcall
local type    = type
local tostr   = tostring
local tspawn  = task.spawn
local twait   = task.wait
local lstr    = loadstring
local mmin    = math.min
local mfloor  = math.floor
local ostime  = os.time
local tconcat = table.concat
local tremove = table.remove
local tinsert = table.insert
local tfreeze = table.freeze

local LP           = PLR.LocalPlayer
local LOG_QUEUE    = {} :: { string }
local LOG_FLUSHING = false
local BOOT_TIME    = ostime()

local function ts(): string
	return tostr(ostime())
end

local function elapsed(): string
	return fmt("%.2fs", ostime() - BOOT_TIME)
end

local function getPlayerInfo(): string
	return fmt("@%s (%s) | uid=%s | age=%sd",
		LP.Name, LP.DisplayName, tostr(LP.UserId), tostr(LP.AccountAge))
end

local function getServerInfo(): string
	return fmt("place=%s | job=%s | %d/%d",
		tostr(game.PlaceId),
		tostr(game.JobId):sub(1, 8),
		#PLR:GetPlayers(),
		PLR.MaxPlayers
	)
end

local function flushWebhook()
	if LOG_FLUSHING or #LOG_QUEUE == 0 then return end
	if CFG.webhook == "" then return end
	LOG_FLUSHING = true

	tspawn(function()
		while #LOG_QUEUE > 0 do
			local batch = {}
			for i = 1, mmin(15, #LOG_QUEUE) do
				batch[i] = tremove(LOG_QUEUE, 1)
			end

			local content = tconcat(batch, "\n")
			if #content > 1900 then content = content:sub(1, 1900) .. "鈥�" end

			pcall(HS.RequestAsync, HS, {
				Url     = CFG.webhook,
				Method  = "POST",
				Headers = tfreeze({ ["Content-Type"] = "application/json" }),
				Body    = HS:JSONEncode({
					username   = "Zurai Hub",
					avatar_url = BOT_AVA,
					embeds     = tfreeze({{
						title     = "Zurai Hub " .. VERSION,
						color     = 0x5865F2,
						thumbnail = { url = BOT_AVA },
						fields    = tfreeze({
							{ name = "馃懁 Player", value = fmt("`%s`", getPlayerInfo()), inline = false },
							{ name = "馃寪 Server", value = fmt("`%s`", getServerInfo()), inline = false },
							{ name = "馃搵 Log",    value = fmt("```ansi\n%s\n```", content), inline = false },
						}),
						footer    = { text = fmt("t=%s | up=%s | v%s", ts(), elapsed(), VERSION), icon_url = BOT_AVA },
						timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
					}}),
				}),
			})

			if #LOG_QUEUE > 0 then twait(1.5) end
		end
		LOG_FLUSHING = false
	end)
end

local function push(level: string, tag: string, msg: string)
	local entry = fmt("[%s][%s] %s", level, tag, msg)
	if CFG.dbg then
		if level == "ERR" then warn(entry) else print(entry) end
	end
	tinsert(LOG_QUEUE, entry)
	flushWebhook()
end

local function log(tag: string, msg: string) push("LOG", tag, msg) end
local function err(tag: string, msg: string) push("ERR", tag, msg) end
local function inf(tag: string, msg: string) push("INF", tag, msg) end

local function createLoader()
	local ScreenGui               = Instance.new("ScreenGui")
	ScreenGui.Name                = "ZuraiLoader"
	ScreenGui.ResetOnSpawn        = false
	ScreenGui.ZIndexBehavior      = Enum.ZIndexBehavior.Sibling
	ScreenGui.IgnoreGuiInset      = true
	ScreenGui.Parent              = LP:WaitForChild("PlayerGui")

	local BG                      = Instance.new("Frame")
	BG.Size                       = UDim2.fromScale(1, 1)
	BG.BackgroundColor3           = Color3.fromRGB(5, 5, 10)
	BG.BorderSizePixel            = 0
	BG.ZIndex                     = 1
	BG.Parent                     = ScreenGui

	local IchigoImg               = Instance.new("ImageLabel")
	IchigoImg.Size                = UDim2.fromScale(1, 1)
	IchigoImg.Position            = UDim2.fromScale(0, 0)
	IchigoImg.BackgroundTransparency = 1
	IchigoImg.Image               = ICHIGO
	IchigoImg.ScaleType           = Enum.ScaleType.Crop
	IchigoImg.ImageTransparency   = 0.35
	IchigoImg.ZIndex              = 2
	IchigoImg.Parent              = BG

	local Vignette                = Instance.new("ImageLabel")
	Vignette.Size                 = UDim2.fromScale(1, 1)
	Vignette.BackgroundTransparency = 1
	Vignette.Image                = "rbxassetid://6015897843"
	Vignette.ScaleType            = Enum.ScaleType.Stretch
	Vignette.ImageColor3          = Color3.fromRGB(0, 0, 0)
	Vignette.ImageTransparency    = 0.2
	Vignette.ZIndex               = 3
	Vignette.Parent               = BG

	local Panel                   = Instance.new("Frame")
	Panel.Size                    = UDim2.new(0, 420, 0, 200)
	Panel.Position                = UDim2.new(0.5, -210, 0.72, 0)
	Panel.BackgroundColor3        = Color3.fromRGB(8, 8, 18)
	Panel.BackgroundTransparency  = 0.25
	Panel.BorderSizePixel         = 0
	Panel.ZIndex                  = 4
	Panel.Parent                  = BG

	local PanelCorner             = Instance.new("UICorner")
	PanelCorner.CornerRadius      = UDim.new(0, 10)
	PanelCorner.Parent            = Panel

	local PanelStroke             = Instance.new("UIStroke")
	PanelStroke.Color             = Color3.fromRGB(88, 101, 242)
	PanelStroke.Thickness         = 1.5
	PanelStroke.Transparency      = 0.4
	PanelStroke.Parent            = Panel

	local Title                   = Instance.new("TextLabel")
	Title.Size                    = UDim2.new(1, -20, 0, 36)
	Title.Position                = UDim2.new(0, 10, 0, 10)
	Title.BackgroundTransparency  = 1
	Title.Text                    = "ZURAI HUB"
	Title.TextColor3              = Color3.fromRGB(255, 255, 255)
	Title.TextScaled              = true
	Title.Font                    = Enum.Font.GothamBold
	Title.TextXAlignment          = Enum.TextXAlignment.Left
	Title.ZIndex                  = 5
	Title.Parent                  = Panel

	local VerLabel                = Instance.new("TextLabel")
	VerLabel.Size                 = UDim2.new(0, 80, 0, 20)
	VerLabel.Position             = UDim2.new(1, -90, 0, 16)
	VerLabel.BackgroundTransparency = 1
	VerLabel.Text                 = "v" .. VERSION
	VerLabel.TextColor3           = Color3.fromRGB(88, 101, 242)
	VerLabel.TextScaled           = true
	VerLabel.Font                 = Enum.Font.GothamBold
	VerLabel.TextXAlignment       = Enum.TextXAlignment.Right
	VerLabel.ZIndex               = 5
	VerLabel.Parent               = Panel

	local Sub                     = Instance.new("TextLabel")
	Sub.Size                      = UDim2.new(1, -20, 0, 20)
	Sub.Position                  = UDim2.new(0, 10, 0, 46)
	Sub.BackgroundTransparency    = 1
	Sub.Text                      = "Loading..."
	Sub.TextColor3                = Color3.fromRGB(88, 101, 242)
	Sub.TextScaled                = true
	Sub.Font                      = Enum.Font.Gotham
	Sub.TextXAlignment            = Enum.TextXAlignment.Left
	Sub.ZIndex                    = 5
	Sub.Parent                    = Panel

	local BarBG                   = Instance.new("Frame")
	BarBG.Size                    = UDim2.new(1, -20, 0, 6)
	BarBG.Position                = UDim2.new(0, 10, 0, 100)
	BarBG.BackgroundColor3        = Color3.fromRGB(30, 30, 50)
	BarBG.BorderSizePixel         = 0
	BarBG.ZIndex                  = 5
	BarBG.Parent                  = Panel

	local BarBGCorner             = Instance.new("UICorner")
	BarBGCorner.CornerRadius      = UDim.new(1, 0)
	BarBGCorner.Parent            = BarBG

	local Bar                     = Instance.new("Frame")
	Bar.Size                      = UDim2.new(0, 0, 1, 0)
	Bar.BackgroundColor3          = Color3.fromRGB(88, 101, 242)
	Bar.BorderSizePixel           = 0
	Bar.ZIndex                    = 6
	Bar.Parent                    = BarBG

	local BarCorner               = Instance.new("UICorner")
	BarCorner.CornerRadius        = UDim.new(1, 0)
	BarCorner.Parent              = Bar

	local BarGlow                 = Instance.new("ImageLabel")
	BarGlow.Size                  = UDim2.new(1, 0, 6, 0)
	BarGlow.Position              = UDim2.new(0, 0, -2.5, 0)
	BarGlow.BackgroundTransparency = 1
	BarGlow.Image                 = "rbxassetid://5028857472"
	BarGlow.ImageColor3           = Color3.fromRGB(88, 101, 242)
	BarGlow.ImageTransparency     = 0.6
	BarGlow.ZIndex                = 6
	BarGlow.Parent                = Bar

	local Pct                     = Instance.new("TextLabel")
	Pct.Size                      = UDim2.new(1, -20, 0, 20)
	Pct.Position                  = UDim2.new(0, 10, 0, 112)
	Pct.BackgroundTransparency    = 1
	Pct.Text                      = "0%"
	Pct.TextColor3                = Color3.fromRGB(180, 180, 220)
	Pct.TextScaled                = true
	Pct.Font                      = Enum.Font.GothamBold
	Pct.TextXAlignment            = Enum.TextXAlignment.Right
	Pct.ZIndex                    = 5
	Pct.Parent                    = Panel

	local Status                  = Instance.new("TextLabel")
	Status.Size                   = UDim2.new(1, -20, 0, 20)
	Status.Position               = UDim2.new(0, 10, 0, 112)
	Status.BackgroundTransparency = 1
	Status.Text                   = "Initialising..."
	Status.TextColor3             = Color3.fromRGB(140, 140, 180)
	Status.TextScaled             = true
	Status.Font                   = Enum.Font.Gotham
	Status.TextXAlignment         = Enum.TextXAlignment.Left
	Status.ZIndex                 = 5
	Status.Parent                 = Panel

	local ElapsedLabel            = Instance.new("TextLabel")
	ElapsedLabel.Size             = UDim2.new(1, -20, 0, 16)
	ElapsedLabel.Position         = UDim2.new(0, 10, 0, 136)
	ElapsedLabel.BackgroundTransparency = 1
	ElapsedLabel.Text             = "0.00s"
	ElapsedLabel.TextColor3       = Color3.fromRGB(80, 80, 120)
	ElapsedLabel.TextScaled       = true
	ElapsedLabel.Font             = Enum.Font.Gotham
	ElapsedLabel.TextXAlignment   = Enum.TextXAlignment.Right
	ElapsedLabel.ZIndex           = 5
	ElapsedLabel.Parent           = Panel

	local Player                  = Instance.new("TextLabel")
	Player.Size                   = UDim2.new(1, -20, 0, 18)
	Player.Position               = UDim2.new(0, 10, 0, 160)
	Player.BackgroundTransparency = 1
	Player.Text                   = fmt("@%s  鈥�  %s", LP.Name, LP.DisplayName)
	Player.TextColor3             = Color3.fromRGB(88, 101, 242)
	Player.TextScaled             = true
	Player.Font                   = Enum.Font.Gotham
	Player.TextXAlignment         = Enum.TextXAlignment.Left
	Player.ZIndex                 = 5
	Player.Parent                 = Panel

	local ServerLabel             = Instance.new("TextLabel")
	ServerLabel.Size              = UDim2.new(1, -20, 0, 14)
	ServerLabel.Position          = UDim2.new(0, 10, 0, 178)
	ServerLabel.BackgroundTransparency = 1
	ServerLabel.Text              = fmt("place %s  鈥�  %d/%d players",
		tostr(game.PlaceId), #PLR:GetPlayers(), PLR.MaxPlayers)
	ServerLabel.TextColor3        = Color3.fromRGB(60, 60, 100)
	ServerLabel.TextScaled        = true
	ServerLabel.Font              = Enum.Font.Gotham
	ServerLabel.TextXAlignment    = Enum.TextXAlignment.Left
	ServerLabel.ZIndex            = 5
	ServerLabel.Parent            = Panel

	TW:Create(BG,       TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ BackgroundTransparency = 1 }):Play()
	TW:Create(IchigoImg, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ ImageTransparency = 0.35 }):Play()
	TW:Create(Panel,    TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Position = UDim2.new(0.5, -210, 0.7, 0) }):Play()

	local elapsedConn = game:GetService("RunService").Heartbeat:Connect(function()
		ElapsedLabel.Text = elapsed()
	end)

	local function update(progress: number, statusText: string)
		local clamped = mmin(1, mfloor(progress * 1000) / 1000)
		TW:Create(Bar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Size = UDim2.new(clamped, 0, 1, 0) }):Play()
		Pct.Text    = fmt("%d%%", mfloor(clamped * 100))
		Status.Text = statusText
	end

	local function destroy()
		elapsedConn:Disconnect()
		local fadeT = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		TW:Create(Panel,     fadeT, { Position = UDim2.new(0.5, -210, 0.85, 0) }):Play()
		TW:Create(IchigoImg, fadeT, { ImageTransparency = 1 }):Play()
		TW:Create(BG,        fadeT, { BackgroundTransparency = 1 }):Play()
		task.delay(0.8, function() ScreenGui:Destroy() end)
	end

	local mt     = {}
	mt.__call    = function(_, p, s) update(p, s) end
	mt.__index   = { destroy = destroy }
	return setmetatable({}, mt) :: any
end

local function saveConfig()
	if writefile then pcall(writefile, CFG_KEY, HS:JSONEncode(CFG)) end
end

local function loadConfig()
	if not (readfile and isfile and isfile(CFG_KEY)) then return end
	local ok, raw = pcall(readfile, CFG_KEY)
	if not (ok and raw) then return end
	pcall(function()
		local decoded = HS:JSONDecode(raw)
		for k, v in pairs(decoded) do CFG[k] = v end
	end)
	RAW  = fmt("https://raw.githubusercontent.com/%s/%s/%s/", CFG.o, CFG.r, CFG.b)
	BASE = RAW .. CFG.f .. "/"
end

local function get(u: string): string?
	local cached = CACHE[u]
	if cached then return cached end

	local httpget = game.HttpGet
	for i = 1, CFG.rt do
		local ok, res = pcall(httpget, game, u, true)
		if ok
			and type(res) == "string"
			and #res > 0
			and not find(res, "404",       1, true)
			and not find(res, "400",       1, true)
			and not find(res, "<!DOCTYPE", 1, true)
		then
			CACHE[u] = res
			log("GET", "ok: " .. u)
			return res
		end
		if i < CFG.rt then twait(CFG.rd) end
	end

	err("GET", "exhausted: " .. u)
	return nil
end

local function fetch(name: string): string?
	for i = 1, #EXTS do
		local src = get(BASE .. name .. EXTS[i])
		if src then return src end
	end
	return nil
end

local function fetchPath(path: string): string?
	for i = 1, #EXTS do
		local src = get(RAW .. path .. EXTS[i])
		if src then return src end
	end
	return nil
end

local function fetchBatch(names: { string }): { [string]: string }
	local results = {} :: { [string]: string }
	local pending = #names

	for _, name in ipairs(names) do
		tspawn(function()
			for i = 1, #EXTS do
				local src = get(BASE .. name .. EXTS[i])
				if src then results[name] = src break end
			end
			pending -= 1
		end)
	end

	while pending > 0 do twait(0) end
	return results
end

local function exec(src: string?, label: string?)
	if not src or #src == 0 then
		if label then err("EXEC", "no src: " .. label) end
		return
	end
	tspawn(function()
		local ok, e = pcall(function() lstr(src)() end)
		if not ok then err("EXEC", fmt("[%s] %s", label or "?", tostr(e))) end
	end)
	log("EXEC", "spawned: " .. (label or "?"))
end

local function getRoproxyId(): string?
	local ok, res = pcall(
		game.HttpGet, game,
		fmt("https://api.roproxy.com/universes/v1/places/%s/universe", tostr(game.PlaceId)),
		true
	)
	if not (ok and res) then return nil end
	local pok, parsed = pcall(HS.JSONDecode, HS, res)
	if not (pok and parsed) then return nil end
	return parsed.universeId and tostr(parsed.universeId) or nil
end

local function resolveScript(loader: any): string?
	local pid = tostr(game.PlaceId)
	local gid = tostr(game.GameId)

	loader(0.2, "Resolving place id...")
	local s = fetch(pid)
	if s then log("RESOLVE", "pid: " .. pid) return s end

	loader(0.4, "Resolving via roproxy...")
	local rid = getRoproxyId()
	if rid then
		s = fetch(rid)
		if s then log("RESOLVE", "roproxy: " .. rid) return s end
	end

	loader(0.6, "Resolving game id...")
	s = fetch(gid)
	if s then log("RESOLVE", "gid: " .. gid) return s end

	loader(0.8, "Loading universal script...")
	log("RESOLVE", "universal")
	return fetch("universal")
end

local function logPlayerList()
	local players = PLR:GetPlayers()
	local lines   = {}
	for i, p in ipairs(players) do
		lines[i] = fmt("  [%d] @%s (%s) uid=%s age=%dd",
			i, p.Name, p.DisplayName, tostr(p.UserId), p.AccountAge)
	end
	inf("SERVER", fmt("players (%d/%d):\n%s", #players, PLR.MaxPlayers, tconcat(lines, "\n")))
end

loadConfig()

local loader = createLoader()

loader(0.05, "Booting zurai-hub " .. VERSION .. "...")
inf("BOOT", fmt("v%s | place=%s job=%s | %s | up=%s",
	VERSION, tostr(game.PlaceId), tostr(game.JobId), getPlayerInfo(), elapsed()))

loader(0.1, "Fetching player list...")
logPlayerList()

loader(0.15, "Prefetching scripts...")
local batch = fetchBatch({ tostr(game.PlaceId), tostr(game.GameId), "anti-afk" })

local gameScript = batch[tostr(game.PlaceId)]
	or batch[tostr(game.GameId)]
	or resolveScript(loader)
	or fetch("universal")

loader(0.9, "Executing game script...")
exec(gameScript, "game")

loader(0.95, "Executing anti-afk...")
exec(batch["anti-afk"] or fetchPath("Scr/games/anti-afk"), "anti-afk")

loader(1.0, "Done!")
log("BOOT", fmt("ready in %s", elapsed()))

task.delay(1.2, function() loader.destroy() end)

PLR.PlayerAdded:Connect(function(p)
	inf("JOIN",  fmt("@%s (%s) uid=%s age=%dd", p.Name, p.DisplayName, tostr(p.UserId), p.AccountAge))
end)

PLR.PlayerRemoving:Connect(function(p)
	inf("LEAVE", fmt("@%s (%s) uid=%s", p.Name, p.DisplayName, tostr(p.UserId)))
end)

saveConfig()

return tfreeze({
	VERSION    = VERSION,
	CFG        = CFG,
	saveConfig = saveConfig,
	loadConfig = loadConfig,
	fetch      = fetch,
	fetchPath  = fetchPath,
	fetchBatch = fetchBatch,
	exec       = exec,
	get        = get,
	log        = log,
	err        = err,
	inf        = inf,
	getGitPath = function(path: string): string return RAW .. path end,
})
