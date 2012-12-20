def pick_to_index(pick_string):
    pick_string = pick_string or 'first'
    pick = pick_string.lower().strip()
    if pick == "first":
        return 0
    elif pick == "last":
        return -1
    return int(pick.strip('st nd th')) - 1  # strip 'th' or 'rd off
