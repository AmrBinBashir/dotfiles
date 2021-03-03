import sys

output_data_file = "/tmp/.awesomewm-workspaces-polybar-data"
formatted_wokrspaces_string = ""

for entry in sys.argv[1].split("/"):
    """
    skip empty entries
    """
    if entry == "":
        continue
    """
    each entry should be like:
        1-full-active
        2-empty-inactive
    """
    [workspace, full_or_empty, active_or_not] = entry.split("-")

    if active_or_not == "active":
        workspace = "%{B#5e35b1}%{F#fff} " + workspace + " "
    else:
        if full_or_empty == "full":
            bg = "%{B#BF3D3C3C}"
        else:
            bg = "%{B#BF1F1F1F}"
        workspace = bg + "%{F#ccc} " + workspace + " "
    formatted_wokrspaces_string += workspace

with open(output_data_file, "w") as f:
    f.write(formatted_wokrspaces_string)
