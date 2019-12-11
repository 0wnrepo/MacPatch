from flask import render_template
from flask_login import login_required, current_user
from sqlalchemy import text
from datetime import datetime, timedelta
from operator import itemgetter

import json
import os
import humanize

from . import maint
from .. import login_manager
from .. import db
from ..model import *


@maint.route('/maint')
@login_required
def index():
	result = []
	qSW = MpSoftware.query.all()

	for s in qSW:
		files = getFilesInDirToRemove(s.sw_path)
		if len(files) >= 1:
			row = {}
			row['name'] = s.sName
			row['pkgPath'] = s.sw_path
			files = getFilesInDirToRemove(s.sw_path)
			row['rmFiles'] = files
			result.append(row)

	return render_template('maint/maint.html', data=result)


def getFilesInDirToRemove(sw_path):
	files = []
	if sw_path is not None:
		if os.path.exists(sw_path):
			_files = []
			path = os.path.dirname(sw_path)
			files = os.listdir(path)
			for f in files:
				fullFileName = os.path.join(path, f)
				if fullFileName == sw_path:
					continue
				elif ".png" in f:
					continue
				elif ".jpg" in f:
					continue
				elif ".gif" in f:
					continue
				_fileInfo = "{} {}".format(fullFileName,humanize.naturalsize(os.path.getsize(fullFileName)))
				_files.append(_fileInfo)

			files = _files

	return files

@maint.route('/orphan')
@login_required
def orphan():
	results = []
	result = []
	dirs = []
	suuids = []
	qSW = MpSoftware.query.all()
	for d in os.walk('/opt/MPContent/Web/sw'):
		dirname = os.path.basename(d[0])
		dirs.append(dirname)

	for s in qSW:
		suuids.append(s.suuid)

	result = [[x for x in dirs if x not in suuids], [x for x in suuids if x not in dirs]]
	for f in result:
		for x in f:
			results.append(os.path.join('/opt/MPContent/Web/sw',x))

	return render_template('maint/orphan.html', data=results)