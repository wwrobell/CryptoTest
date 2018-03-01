clc
close all
clearvars

import_tids

last_tid = VarName1(end);
python('refresh_data.py',int2str(last_tid))
import_data
