{h,Component} = require 'preact'
Toggle = require './preact-slide-toggle.coffee'
Slide = require 'preact-slide'
require './sample.less'

class Sample
	render: ->
		h 'div',
			className: 'sample'
			h Slide,
				height: 40
				vert: false
				h Toggle,
					square: true

module.exports = Sample