def pick_to_index(pick_string):
    pick_string = pick_string or 'first'
    pick = pick_string.lower().strip()
    if pick == "first":
        return 0
    elif pick == "last":
        return -1
    try:
        return int(pick.strip('st nd rd th')) - 1
    except ValueError:
        raise ValueError("Could not convert '%s'" % pick +
                " This supports: 'first', 'last', '1st', '2nd', '3rd', '4th', '5th',..")
