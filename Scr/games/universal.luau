--!strict

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

local CFG = {
	o  = "zurai02",
	r  = "zurai-hub",
	b  = "main",
	f  = "Scr/games",
	rt = 3,
	rd = 1.5,
}

local HS               = game:GetService("HttpService")
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer      = Players.LocalPlayer

local CFG_KEY = "zurai_hub_config.json"
local EXTS    = { ".luau", ".lua" }

local function getGitPath(path: string): string
	return ("https://raw.githubusercontent.com/%s/%s/%s/%s"):format(CFG.o, CFG.r, CFG.b, path)
end

local function saveConfig()
	if writefile then
		pcall(writefile, CFG_KEY, HS:JSONEncode(CFG))
	end
end

local function loadConfig()
	if readfile and isfile and isfile(CFG_KEY) then
		local ok, data = pcall(readfile, CFG_KEY)
		if ok and data then
			pcall(function()
				for k, v in pairs(HS:JSONDecode(data)) do
					CFG[k] = v
				end
			end)
		end
	end
end

loadConfig()

local function get(u: string): string?
	for i = 1, CFG.rt do
		local ok, res = pcall(function()
			return game:HttpGet(u, true)
		end)
		if ok and res and res ~= "" and not res:find("404") and not res:find("400") then
			return res
		end
		if i < CFG.rt then task.wait(CFG.rd) end
	end
	return nil
end

local function fetch(name: string): string?
	for _, ext in ipairs(EXTS) do
		local src = get(getGitPath(CFG.f .. "/" .. name .. ext))
		if src then return src end
	end
	return nil
end

local function fetchPath(path: string): string?
	for _, ext in ipairs(EXTS) do
		local src = get(getGitPath(path .. ext))
		if src then return src end
	end
	return nil
end

local function exec(src: string?)
	if not src or src == "" then return end
	local fn, err = loadstring(src)
	if fn then
		task.spawn(function()
			local ok, runErr = pcall(fn)
			if not ok then warn("[zurai-hub] Runtime error:", runErr) end
		end)
	else
		warn("[zurai-hub] Load error:", err)
	end
end

local function getRoproxyGameId(): string?
	local pid = tostring(game.PlaceId)
	local ok, res = pcall(function()
		return game:HttpGet(
			("https://games.roproxy.com/v1/games/multiget-place-details?placeIds=%s"):format(pid),
			true
		)
	end)
	if not ok or not res then return nil end
	local pok, parsed = pcall(function() return HS:JSONDecode(res) end)
	if not pok or not parsed then return nil end
	local entry = parsed[1]
	if entry and entry.universeId then
		return tostring(entry.universeId)
	end
	return nil
end

local function getHumanoid(): Humanoid?
	local char = LocalPlayer.Character
	if not char then return nil end
	return char:FindFirstChildOfClass("Humanoid")
end

-- State
local WalkSpeedValue = 16
local JumpPowerValue = 50
local InfJumpEnabled = false
local NoclipEnabled  = false
local ESPEnabled     = false
local FlyEnabled     = false
local FlySpeed       = 50

-- Noclip
RunService.Stepped:Connect(function()
	if not NoclipEnabled then return end
	local char = LocalPlayer.Character
	if not char then return end
	for _, part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
		end
	end
end)

-- Infinite jump
UserInputService.JumpRequest:Connect(function()
	if not InfJumpEnabled then return end
	local hum = getHumanoid()
	if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- Fly
local flyConn: RBXScriptConnection?
local function startFly()
	local char = LocalPlayer.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart") :: BasePart?
	local hum = getHumanoid()
	if not hrp or not hum then return end
	hum.PlatformStand = true
	local bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
	bg.P = 1e4
	bg.Parent = hrp
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	bv.Velocity = Vector3.zero
	bv.Parent = hrp
	flyConn = RunService.RenderStepped:Connect(function()
		if not FlyEnabled then
			bg:Destroy()
			bv:Destroy()
			hum.PlatformStand = false
			if flyConn then flyConn:Disconnect() end
			return
		end
		local cam = workspace.CurrentCamera
		local dir = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0, 1, 0) end
		bv.Velocity = dir.Magnitude > 0 and dir.Unit * FlySpeed or Vector3.zero
		bg.CFrame = cam.CFrame
	end)
end

-- ESP
local function setupESP(player: Player, char: Model)
	if not char:FindFirstChild("ZuraiESP_Highlight") then
		local hl = Instance.new("Highlight")
		hl.Name               = "ZuraiESP_Highlight"
		hl.FillColor          = Color3.fromRGB(255, 0, 0)
		hl.OutlineColor       = Color3.fromRGB(255, 255, 255)
		hl.FillTransparency   = 0.5
		hl.OutlineTransparency = 0
		hl.Adornee            = char
		hl.Parent             = char
	end
	local head = char:WaitForChild("Head", 5) :: BasePart?
	if head and not head:FindFirstChild("ZuraiESP_Tag") then
		local bb = Instance.new("BillboardGui")
		bb.Name        = "ZuraiESP_Tag"
		bb.Adornee     = head
		bb.Size        = UDim2.new(0, 100, 0, 50)
		bb.StudsOffset = Vector3.new(0, 2, 0)
		bb.AlwaysOnTop = true
		local lbl = Instance.new("TextLabel")
		lbl.Size                   = UDim2.new(1, 0, 1, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text                   = player.Name
		lbl.TextColor3             = Color3.fromRGB(255, 255, 255)
		lbl.TextScaled             = true
		lbl.Font                   = Enum.Font.SourceSansBold
		lbl.Parent                 = bb
		bb.Parent = head
	end
end

local function removeESP(player: Player)
	local char = player.Character
	if not char then return end
	local hl = char:FindFirstChild("ZuraiESP_Highlight")
	if hl then hl:Destroy() end
	local head = char:FindFirstChild("Head")
	if head then
		local tag = head:FindFirstChild("ZuraiESP_Tag")
		if tag then tag:Destroy() end
	end
end

local function applyESP(player: Player)
	if player == LocalPlayer then return end
	if player.Character then setupESP(player, player.Character) end
	player.CharacterAdded:Connect(function(c)
		if ESPEnabled then setupESP(player, c) end
	end)
end

local function toggleESP(enabled: boolean)
	ESPEnabled = enabled
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			if enabled then applyESP(p) else removeESP(p) end
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	if ESPEnabled then applyESP(player) end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
	local hum = char:WaitForChild("Humanoid") :: Humanoid
	hum.WalkSpeed    = WalkSpeedValue
	hum.UseJumpPower = true
	hum.JumpPower    = JumpPowerValue
end)

-- Load NovaUI
local NovaUI = loadstring(game:HttpGet(getGitPath("Scr/UI.lua"), true))()

local Window = NovaUI:CreateWindow({
	Title     = "Zurai Hub",
	Subtitle  = "Universal",
	Theme     = "Dark",
	ToggleKey = Enum.KeyCode.RightControl,
})

-- ── Player Tab ───────────────────────────────────────────────────
local PlayerTab = Window:CreateTab("Player")

PlayerTab:CreateSection("Movement")

PlayerTab:CreateSlider({
	Name         = "Walk Speed",
	Range        = { 16, 500 },
	Increment    = 1,
	CurrentValue = 16,
	Flag         = "WalkSpeed",
	Callback     = function(val: number)
		WalkSpeedValue = val
		local hum = getHumanoid()
		if hum then hum.WalkSpeed = val end
	end,
})

PlayerTab:CreateSlider({
	Name         = "Jump Power",
	Range        = { 50, 500 },
	Increment    = 1,
	CurrentValue = 50,
	Flag         = "JumpPower",
	Callback     = function(val: number)
		JumpPowerValue = val
		local hum = getHumanoid()
		if hum then
			hum.UseJumpPower = true
			hum.JumpPower    = val
		end
	end,
})

PlayerTab:CreateSection("Abilities")

PlayerTab:CreateToggle({
	Name         = "Infinite Jump",
	CurrentValue = false,
	Flag         = "InfJump",
	Callback     = function(val: boolean) InfJumpEnabled = val end,
})

PlayerTab:CreateToggle({
	Name         = "Noclip",
	CurrentValue = false,
	Flag         = "Noclip",
	Callback     = function(val: boolean) NoclipEnabled = val end,
})

PlayerTab:CreateToggle({
	Name         = "Fly",
	CurrentValue = false,
	Flag         = "Fly",
	Callback     = function(val: boolean)
		FlyEnabled = val
		if val then startFly() end
	end,
})

PlayerTab:CreateSlider({
	Name         = "Fly Speed",
	Range        = { 10, 300 },
	Increment    = 5,
	CurrentValue = 50,
	Flag         = "FlySpeed",
	Callback     = function(val: number) FlySpeed = val end,
})

PlayerTab:CreateSection("Teleport")

PlayerTab:CreateDropdown({
	Name    = "Teleport to Player",
	Options = (function()
		local names: { string } = {}
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer then
				table.insert(names, p.Name)
			end
		end
		return names
	end)(),
	Flag     = "TeleportTarget",
	Callback = function(name: string)
		local target = Players:FindFirstChild(name) :: Player?
		if not target or not target.Character then return end
		local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") :: BasePart?
		local tHrp = target.Character:FindFirstChild("HumanoidRootPart") :: BasePart?
		if hrp and tHrp then
			hrp.CFrame = tHrp.CFrame + Vector3.new(3, 0, 0)
		end
	end,
})

PlayerTab:CreateButton({
	Name     = "Bring All Players",
	Callback = function()
		local char = LocalPlayer.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart") :: BasePart?
		if not hrp then return end
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
				local tHrp = p.Character:FindFirstChild("HumanoidRootPart") :: BasePart?
				if tHrp then
					tHrp.CFrame = hrp.CFrame + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
				end
			end
		end
	end,
})

-- ── Visuals Tab ──────────────────────────────────────────────────
local VisualsTab = Window:CreateTab("Visuals")

VisualsTab:CreateSection("Players")

VisualsTab:CreateToggle({
	Name         = "Player ESP",
	CurrentValue = false,
	Flag         = "ESP",
	Callback     = function(val: boolean) toggleESP(val) end,
})

VisualsTab:CreateColorPicker({
	Name         = "ESP Fill Color",
	CurrentColor = Color3.fromRGB(255, 0, 0),
	Flag         = "ESPFillColor",
	Callback     = function(col: Color3)
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
				local hl = p.Character:FindFirstChild("ZuraiESP_Highlight") :: Highlight?
				if hl then hl.FillColor = col end
			end
		end
	end,
})

VisualsTab:CreateColorPicker({
	Name         = "ESP Outline Color",
	CurrentColor = Color3.fromRGB(255, 255, 255),
	Flag         = "ESPOutlineColor",
	Callback     = function(col: Color3)
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
				local hl = p.Character:FindFirstChild("ZuraiESP_Highlight") :: Highlight?
				if hl then hl.OutlineColor = col end
			end
		end
	end,
})

VisualsTab:CreateSection("World")

VisualsTab:CreateToggle({
	Name         = "Fullbright",
	CurrentValue = false,
	Flag         = "Fullbright",
	Callback     = function(val: boolean)
		local lighting = game:GetService("Lighting")
		lighting.Brightness       = val and 2 or 1
		lighting.ClockTime        = val and 14 or 14
		lighting.FogEnd           = val and 1e6 or 100000
		lighting.GlobalShadows    = not val
		lighting.Ambient          = val and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(127, 127, 127)
		lighting.OutdoorAmbient   = val and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(127, 127, 127)
	end,
})

-- ── Config Tab ───────────────────────────────────────────────────
local ConfigTab = Window:CreateTab("Config")

ConfigTab:CreateSection("Theme")

ConfigTab:CreateDropdown({
	Name    = "UI Theme",
	Options = { "Dark", "Light", "Ocean", "Amethyst", "Emerald" },
	CurrentOption = "Dark",
	Flag    = "UITheme",
	Callback = function(val: string)
		NovaUI:Notify({
			Title    = "Theme",
			Content  = val .. " applied on next load.",
			Type     = "Success",
			Duration = 3,
		})
	end,
})

ConfigTab:CreateSection("Keybinds")

ConfigTab:CreateKeybind({
	Name           = "Toggle UI",
	CurrentKeybind = Enum.KeyCode.RightControl,
	Flag           = "ToggleKey",
	Callback       = function(_key: Enum.KeyCode) end,
})

ConfigTab:CreateSection("Save / Load")

ConfigTab:CreateConfigManager()

-- ── Info Tab ─────────────────────────────────────────────────────
local InfoTab = Window:CreateTab("Info")

InfoTab:CreateParagraph({
	Title   = "Zurai Hub",
	Content = "Universal script loader. Loads game-specific scripts automatically.",
})

InfoTab:CreateParagraph({
	Title   = "Keybinds",
	Content = "Toggle UI: Right Control\nFly: WASD + Space (up) + Ctrl (down) while active.",
})

InfoTab:CreateDivider()

InfoTab:CreateButton({
	Name     = "Copy Discord",
	Callback = function()
		NovaUI:Notify({
			Title    = "Discord",
			Content  = "discord.gg/zuraihub",
			Type     = "Success",
			Duration = 5,
		})
	end,
})

-- ── Loader ───────────────────────────────────────────────────────
local pid = tostring(game.PlaceId)
local gid = tostring(game.GameId)

local gameScript: string? =
	fetch(pid)
	or (function()
		local rgid = getRoproxyGameId()
		return rgid and fetch(rgid) or nil
	end)()
	or fetch(gid)
	or fetch("universal")

exec(gameScript)
exec(fetch("anti-afk") or fetchPath("Scr/games/anti-afk"))

saveConfig()

NovaUI:Notify({
	Title    = "Zurai Hub",
	Content  = "Loaded successfully.",
	Type     = "Success",
	Duration = 4,
})

return {
	CFG        = CFG,
	saveConfig = saveConfig,
	loadConfig = loadConfig,
	getGitPath = getGitPath,
	fetch      = fetch,
	fetchPath  = fetchPath,
	exec       = exec,
	NovaUI     = NovaUI,
	Window     = Window,
}