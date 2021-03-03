input_data_file = "/tmp/.awesomewm-workspaces-data"
output_data_file = "/tmp/.awesomewm-workspaces-polybar"
formatted_wokrspaces_string = ""

with open(input_data_file, "r") as f:
    for line in f.readlines():
        """
        skip empty lines
        """
        if line == "\n":
            continue
        """
        each line should be like:
            1 full active
            2 empty inactive
        """
        [workspace, full_or_empty, active_or_not] = line.replace("\n", "").split(" ")

        if active_or_not == "active":
            workspace = "%{B#5e35b1}%{F#ffffff} " + workspace + " "
        else:
            if full_or_empty == "full":
                bg = "%{B#BF3D3C3C}"
            else:
                bg = "%{B#00000000}"
            workspace = bg + "%{F#cccccc} " + workspace + " "
        formatted_wokrspaces_string += workspace

with open(output_data_file, "w") as f:
    f.write(formatted_wokrspaces_string)
