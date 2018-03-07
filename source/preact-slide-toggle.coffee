{h,Component} = require 'preact'
Slide = require 'preact-slide'
require './preact-slide-toggle.less'


class SlideToggle extends Component
	constructor: (props)->
		super(props)
		@state=
			toggle_on : false
	toggleState: =>
		@setState
			toggle_on: !@state.toggle_on
	render: ->
		h Slide,
			onClick: @toggleState
			className: '-i-slide-toggle'
			vert: false
			slide: yes
			ratio: 2
			pos: !@state.toggle_on && 2 || 0
			style: 
				background: 'lightgrey'
			h Slide,
				beta: 50
				style:
					opacity: 0.5
					background: 'green'
			h Slide,
				className: '-i-slide-toggle-bar'
				beta: 50
				style:
					background: @state.toggle_on && 'green' || 'grey'
			h Slide,
				beta: 50


module.exports = SlideToggle