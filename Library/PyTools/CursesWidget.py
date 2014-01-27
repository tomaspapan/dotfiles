"""
Package CursesWidget.
"""

import curses

SCREEN_TOP=0
SCREEN_BOTTOM=1

SCROLL_VISIBLE=0
SCROLL_TOP=1
SCROLL_CENTER=2
SCROLL_BOTTOM=3

class Listview:
	def __init__(self, parent, data=None):
		self.__maxcols = 0

		self.parent = parent
		self.setData(data)

		self.foreground = curses.A_REVERSE
		self.background = curses.A_NORMAL

		py = px = my = mx = 0
		if self.parent:
			py, px = parent.getparyx()
			my, mx = parent.getmaxyx()

		self.layout = (py, px, my, mx)

	def clear(self):
		if self.__pad: self.__pad.clear()

	def getData(self):
		return self.__data

	def setData(self, data):
		if data:
			self.__maxcols = 0
			for item in data:
				self.__maxcols = max(self.__maxcols, len(str(item)) +1)
			self.__pad = curses.newpad(len(data), self.__maxcols)
		else:
			self.__pad = None

		self.__pminrow = self.currentIndex = 0
		self.__data = data

	def refresh(self):
		if not self.__pad:
			return
		y = 0
		for item in self.__data:
			pstr = str(item) + ' '* (self.__maxcols - len(str(item)) -1)
			if y == self.currentIndex:
				self.__pad.addstr(y, 0, pstr, self.foreground)
			else:
				self.__pad.addstr(y, 0, pstr, self.background)
			y += 1

		minrow, mincol, maxrow, maxcol = self.layout
		self.__pad.refresh(self.__pminrow, 0, minrow, mincol, maxrow, maxcol)		

	def scrollTo(self, index, hint=SCROLL_VISIBLE):
		if not self.__pad:
			return
		if (index < 0 or index > len(self.__data) -1):
			return
		rows = self.layout[2] - self.layout[0]	
		if (hint == SCROLL_TOP or 
			(hint == SCROLL_VISIBLE and index < self.__pminrow)):
			self.__pminrow = index
		elif (hint == SCROLL_CENTER):
			self.__pminrow = index - rows/2
		elif (hint == SCROLL_BOTTOM or 
			(hint == SCROLL_VISIBLE and index > self.__pminrow + rows)):
			self.__pminrow = index - rows

class Label:
	def __init__(self, parent, text):
		self.parent = parent
		self.text = text
		self.attribute= curses.A_NORMAL

		py = px = mx = 0
		if parent:
			py, px = parent.getparyx()
		if text:
			mx = px + len(str(text))

		self.layout = (py, px, py, mx)
		self.__window = None

	def clear(self):
		if self.__window:
			self.__window.clear()
			self.__window = None

	def refresh(self):
		py, px, my, mx = self.layout
		cols = mx - px
		rows = my - py or 1
		if (not self.__window and self.text):
			self.__window = self.parent.subwin(rows, cols, py, px)

		if self.__window:
			text = self.text or ''
			self.__window.addnstr(0, 0, text + ' '* (cols - len(text) -1), cols, self.attribute)
			self.__window.refresh()

class StatusBar(Label):
	def __init__(self, parent, position=SCREEN_BOTTOM):
		Label.__init__(self, parent, None)
		self.attribute = curses.A_NORMAL

		begin_y, cols = parent.getmaxyx()
		if (position == SCREEN_TOP):
			begin_y = 0
		elif (position == SCREEN_BOTTOM):
			begin_y -= 1
		self.layout = (begin_y, 0, begin_y +1, cols)
