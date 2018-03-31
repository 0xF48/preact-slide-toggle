{h,Component} = require 'preact'
Slide = require 'preact-slide'
require './preact-slide-toggle.less'
class SlideToggle extends Component
	constructor: (props)->
		super(props)
		@state = 
			hover: false
	onMouseEnter: =>

		if !@state.hover
			@setState
				hover:yes
		@props.onMouseEnter?()
		
	onMouseLeave: =>
		
		if @state.hover
			@setState
				hover:no
		@props.onMouseLeave?()

	render: ->

		if (@props.barBeta)?
			bar_beta = (@props.barBeta)
			beta = 100 - (@props.barBeta)
		else
			beta = 50
			bar_beta = 50

		disabled = @props.disabled || !@props.onToggle
		pos = !@props.toggle &&  (@props.barBeta != 0 && 2 || 1) || 0
		
		if @state.hover && !@props.disabled
			if @props.toggle
				pos = @props.offset || 0.1
			else
				pos = 1 - (@props.offset || 0.1)
				

		disabled_cl = disabled && ' -i-slide-toggle-disabled' || ''
		props = 
			onClick: !disabled && @props.onToggle
			slide: yes
			pos: pos
			onMouseEnter: @onMouseEnter
			onMouseLeave: @onMouseLeave
		Object.assign props,@props
		props.className = '-i-slide-toggle ' + (@props.className) + ' '+disabled_cl

		h Slide, props,
			h Slide,
				beta: beta
				className: (@props.trueClass || '') + ' -i-slide-toggle-on'
				center: yes
				@props.trueChild||''
			@props.barBeta != 0 && h Slide,
				className: (@props.barClass || '') +  ' -i-slide-toggle-bar'
				beta: bar_beta
				center: yes
				@props.barChild
			h Slide,
				className: (@props.falseClass || '') + ' -i-slide-toggle-off'
				beta: beta
				center: yes
				@props.falseChild||''


module.exports = SlideToggle