# Returns all db files sorted by modified time. Usually the last one is your sqlite db file.

find /Users/sayyidkhan/Library/Developer/CoreSimulator/Devices/ -name "*.db" -printf "%T+\t%p\n" | sort