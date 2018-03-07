Using the default setup is as easy as 
<pre>
	my_component = h Toggle,
		onChild: 'on'
		offChild: 'off'
		toggle: true || false
</pre>


You can also extend the Toggle class and set the default props.
<pre>
	Toggle = require 'preact-slide-toggle'
	.....
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
</pre>