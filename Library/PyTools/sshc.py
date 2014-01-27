"""
Putty-like console program.
"""

import curses
import CursesWidget
import os
import sys

from ConfigParser import ConfigParser
from optparse import OptionParser

from UserDict import UserDict

class Session:
	def __init__(self, name, host, opts):
		self.name = name
		self.host = host
		self.options = opts

	def __str__(self):
		return " %-25s  %-25s" % (self.name, self.host)

class SessionDict(UserDict):
	def __init__(self):
		UserDict.__init__(self)
		self.currentKey = None

	def read(self, path):
		cfg = ConfigParser()
		cfg.read(path)

		items = cfg.items("Session")
		for (name, value) in items:
			host = opts = None

			params = value.split(",")			
			if len(params) > 0:
				host = params[0]
			if len(params) > 1:
				opts = params[1]

			self.data[name] = Session(name, host, opts)
		
def Main(window, *args, **kwds):
	(max_y, max_x) = window.getmaxyx()

	curses.init_pair(1, curses.COLOR_BLACK, curses.COLOR_WHITE)
	curses.init_pair(2, curses.COLOR_BLACK, curses.COLOR_YELLOW)

	# curses.curs_set(0)

	sessions = args[0].values()
	sessions.sort(lambda a,b: (a.name > b.name) or -1)

	topbar = CursesWidget.StatusBar(window, CursesWidget.SCREEN_TOP)
	topbar.text = "Sessions (%d)  Press 'q' to quit" % len(sessions)
	topbar.attribute = curses.color_pair(1)

	title = CursesWidget.Label(window, "%-25s  %-25s" % ("Name", "Host"))
	title.attribute = curses.A_BOLD
	title.layout = (1, 0, 2, max_x -1)

	listview = CursesWidget.Listview(window, sessions)
	listview.layout = (2, 0, max_y -1, max_x -1)
	listview.foreground = curses.color_pair(2)
	listview.background = curses.color_pair(0)

	window.refresh()
	topbar.refresh()
	title.refresh()

	while 1:
		listview.refresh()

		key = window.getch()
		if (key == curses.KEY_ENTER or key == 10):
			args[0].currentKey = sessions[listview.currentIndex].name
			break
		elif (key == curses.KEY_DOWN):
			listview.currentIndex = min(listview.currentIndex +1, len(sessions) -1)
		elif (key == curses.KEY_UP):
			listview.currentIndex = max(listview.currentIndex -1, 0)
		elif (key == curses.KEY_HOME):
			listview.currentIndex = 0
		elif (key == curses.KEY_END):
			listview.currentIndex = len(sessions) -1
		elif (key == ord('q') or key == ord('Q')):
			break
			
		listview.scrollTo(listview.currentIndex)


if (__name__ == "__main__"):
	script = os.path.basename(sys.argv[0])

	parser = OptionParser(usage="Usage: %prog [options] [session]...", version="%prog 1.0")
	parser.add_option("-c", "--config", dest="config", metavar="FILE",
		help="specifies an alternative per-user configuration file")
	parser.add_option("--ssh-path", dest="ssh", metavar="PATH",
		help="specifies path to ssh binary")
	parser.add_option("-v", "--verbose", dest="verbose",
		action="store_true", default=False,
		help="verbose mode")
	parser.set_defaults(config="%s/%src" % (os.getenv("HOME"), script), ssh="/usr/bin/ssh")

	(options, args) = parser.parse_args()
	if options.verbose:
		print ("%-12s: %s" % ("options", options))
		print ("%-12s: %s" % ("args", args))

	if not os.path.isfile(options.config):
		print ("%s: no such file -- '%s'" % (script, options.config))
		sys.exit(1)
	
	sessions = SessionDict()
	sessions.read(options.config)

	if options.verbose:
		print ('-'*40)
		for (name, obj) in sessions.items():
			print ("%-12s: %s" % (obj.name, obj.host))

	if len(args) == 0:
		curses.wrapper(Main, sessions)
		args.append(sessions.currentKey)

	if options.verbose: print ('-'*40)
	for name in args:
		session = sessions.get(name)
		if session:
			if options.verbose:
				print ("Running '%s' at '%s' -- %s" % (session.name, session.host, session.options))
			sys.stdout.flush()
			if session.options:
				os.execl(options.ssh, os.path.basename(options.ssh), session.options, session.host)
			else:
				os.execl(options.ssh, os.path.basename(options.ssh), session.host)
		elif name != None:
			print ("No such session: '%s'" % name)

