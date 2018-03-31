{h,Component} = require 'preact'
Toggle = require './preact-slide-toggle.coffee'
Slide = require 'preact-slide'
require './sample.less'


class MyToggle extends Toggle
	constructor: (props)->
		super(props)
		console.log @props

MyToggle.defaultProps = 
	barClass : 'bar'
	trueClass : 'on'
	falseClass : 'off'
	height: 60
	vert: yes
	width: 33



class Sample extends Component
	constructor: ->
		super()
		@state=
			toggle1: false
			toggle2: false
			toggle3: false
	
	render: ->		
		h 'div',
			className: 'sample'
			h Slide,
				center: yes
				height: 30
				vert: no
				h Toggle,
					toggle: @state.toggle
					onToggle: =>
						@setState
							toggle: !@state.toggle
							toggle1: !@state.toggle1
							toggle2: !@state.toggle2
							toggle3: !@state.toggle3

					className: 'sample-toggle'
					ratio: 3
					trueChild: 'on'
					falseChild: 'off'
				h Toggle,
					onToggle: =>
						@setState
							disabled: !@state.disabled
					toggle: @state.disabled
					className: 'sample-toggle'
					dim: 30
					barBeta: 20
					ratio: 1
			h Slide,
				center: yes
				style:
					margin: '5px'
				auto: yes
				h MyToggle,
					toggle: @state.toggle1
					onToggle: =>
						@setState
							toggle1: !@state.toggle1
					disabled: @state.disabled
					className: 'sample-toggle blue'
					trueChild: 'v1'
					falseChild: 'v2'
				h MyToggle,
					className: 'sample-toggle colors'
					onToggle: =>
						@setState
							toggle2: !@state.toggle2
					toggle: @state.toggle2
					disabled: @state.disabled
					barBeta: 0
					width: 50
					trueChild: 'red'
					falseChild: 'yellow'
				h MyToggle,
					toggle: @state.toggle3
					onToggle: =>
						@setState
							toggle3: !@state.toggle3
					className: 'sample-toggle blue'
					disabled: @state.disabled
					trueChild: '😎'
					falseChild: '😀'
					inverse: yes
				

module.exports = Sample